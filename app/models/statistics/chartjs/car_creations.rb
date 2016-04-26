module Statistics
  module Chartjs
    class CarCreations < Base
      attr_reader :start_date, :end_date

      def initialize(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
      end

      def labels
        (start_date.to_date..end_date).map { |date| date }
      end

      def datasets
        [
          car_creations_dataset
        ]
      end

      private

      def car_creations_dataset
        {
          label: 'Добавени коли',
          data: car_creations_dataset_data
        }
      end

      def car_creations_dataset_data
        data = Array.new(labels.count, 0)

        car_creations.each do |car_creation|
          data[labels.index(car_creation.date)] = car_creation.count
        end

        data
      end

      def car_creations
        @_car_creations ||= Car.where("created_at >= :creation_date AND created_at <= :today", { creation_date: start_date, today: end_date })
                               .select("date(created_at) as date, count(*) as count")
                               .group("date(created_at)").to_a
      end
    end
  end
end
