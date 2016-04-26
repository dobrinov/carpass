module Statistics
  module Chartjs
    class UserSignins < Base
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
          signins_dataset
        ]
      end

      private

      def signins_dataset
        {
          label: 'Взизания в системата',
          data: signins_dataset_data
        }
      end

      def signins_dataset_data
        data = Array.new(labels.count, 0)

        signins.each do |signin|
          data[labels.index(signin.date)] = signin.count
        end

        data
      end

      def signins
        @_signins ||= User.where("last_login_at >= :login_date AND last_login_at <= :today", { login_date: start_date, today: end_date })
                          .select("date(last_login_at) as date, count(*) as count")
                          .group("date(last_login_at)").to_a
      end
    end
  end
end
