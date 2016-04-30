module Statistics
  module Chartjs
    class CarExpensesByType
      attr_reader :start_date, :end_date

      def initialize(car, start_date=nil)
        @car_histories = Query::CarHistories.new(car, start_date)
      end

      def labels
        histories_structured.keys.map { |type| I18n.t("activerecord.attributes.history.types.#{type}") }
      end

      def datasets
        [
          car_expenses_by_type_dataset
        ]
      end

      private

      def car_expenses_by_type_dataset
        {
          data: car_expenses_by_type_data,
          backgroundColor: [
            "#56E289",
            "#56E2CF",
            "#56AEE2",
            "#5668E2",
            "#8A56E2",
            "#CF56E2",
            "#E256AE",
            "#E25668",
            "#E28956",
            "#E2CF56",
            "#AEE256",
            "#68E256"
          ],
        }
      end

      def car_expenses_by_type_data
        histories_structured.values
      end

      def histories_structured
        structure = {}

        @car_histories.each do |history|
          if history.cost.present?
            structure[history.type] ||= 0.0
            structure[history.type] += history.cost
          end
        end

        structure
      end
    end
  end
end
