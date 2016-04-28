module Statistics
  module Chartjs
    class CarExpensesByMonth
      attr_reader :start_date, :end_date

      def initialize(car, start_date=nil)
        @car = car
        @end_date = Date.today
        @start_date = start_date || histories.first.happened_at
      end

      def labels
        histories_structured.map { |k,v| v['label'] }
      end

      def datasets
        [
          car_expenses_by_month_dataset
        ]
      end

      private

      def car_expenses_by_month_dataset
        {
          label: 'Разходи по месец',
          backgroundColor: "rgba(255,99,132,0.5)",
          borderColor: "rgba(255,99,132,1)",
          borderWidth: 1,
          data: car_expenses_by_month_dataset_data
        }
      end

      def car_expenses_by_month_dataset_data
        histories_structured.map do |k,v|
          v['histories'].inject(0.0) { |sum, history| sum + history.cost }
        end
      end

      def histories_structured
        structure = {}

        (start_date.to_date..end_date).each do |date|
          structure[date.strftime("%Y%m")] ||= {}
          structure[date.strftime("%Y%m")]['histories'] ||= []
          structure[date.strftime("%Y%m")]['label'] = I18n.l(date, format: '%B %Y')
        end

        histories.each do |history|
          if history.cost.present?
            structure[history.happened_at.strftime("%Y%m")]['histories'] << history
          end
        end

        structure
      end

      def histories
        return @_histories if @_histories.present?

        @_histories = @car.histories
                        .where("happened_at <= :end_date", { end_date: end_date })
                        .where("type <> 'ProductionHistory'")
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
