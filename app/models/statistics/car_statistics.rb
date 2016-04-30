module Statistics
  class CarStatistics
    attr_reader :car, :start_date, :end_date

    def initialize(car, start_date=nil)
      @car_histories = Query::CarHistories.new(car, start_date)
    end

    def mileage
      (@car_histories.last_with_mileage.mileage - @car_histories.first_with_mileage.mileage).round(2)
    end

    def average_mileage_per_month
      if months_in_time_interval > 0
        (mileage / months_in_time_interval).round(2)
      else
        mileage
      end
    end

    def expenses
      @car_histories.inject(0.0) do |sum, history|
        if history.cost.present?
          sum + history.cost
        else
          sum
        end
      end
    end

    def average_expenses_per_month
      if months_in_time_interval > 0
        expenses / months_in_time_interval
      else
        expenses
      end
    end

    private

    def months_in_time_interval
      TimeInterval.new(@car_histories.start_date, @car_histories.end_date).months
    end
  end
end
