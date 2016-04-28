module Statistics
  module Chartjs
    class CarExpensesByType
      attr_reader :start_date, :end_date

      def initialize(car, start_date=nil)
        @car = car
        @end_date = Date.today
        @start_date = start_date || histories.first.happened_at
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

        histories.each do |history|
          if history.cost.present?
            structure[history.type] ||= 0.0
            structure[history.type] += history.cost
          end
        end

        structure
      end

      def histories
        return @_histories if @_histories.present?

        @_histories = @car.histories
                        .where("happened_at <= :end_date", { end_date: end_date })
                        .where("type <> 'ProductionHistory'")
                        .where("type <> 'PurchaseHistory'")
                        .where("mileage IS NOT NULL")
                        .order(happened_at: :asc)
                        .order(mileage: :asc)

        if start_date.present?
          @_histories = @_histories.where("happened_at >= :start_date", { start_date: start_date })
        end

        @_histories
      end
    end
  end
end
