module Statistics
  class CarStatistics
    attr_reader :start_date, :end_date

    def initialize(car, start_date=nil)
      @car = car
      @start_date = start_date
      @end_date = Date.today
    end

    def expenses
      histories.inject(0.0) do |sum, history|
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

    def mileage
      (last_history_in_interval.mileage - first_history_in_interval.mileage).round(2)
    end

    def average_mileage_per_month
      if months_in_time_interval > 0
        (mileage / months_in_time_interval).round(2)
      else
        mileage
      end
    end

    private

    def months_in_time_interval
      (last_history_in_interval.happened_at - first_history_in_interval.happened_at) / 1.month
    end

    def first_history_in_interval
      histories.select { |h| h.mileage.present? }.first || NullHistory.new
    end

    def last_history_in_interval
      histories.select { |h| h.mileage.present? }.last || NullHistory.new
    end

    def histories
      return @_histories if @_histories.present?

      @_histories = @car.histories
                      .where("happened_at <= :end_date", { end_date: end_date })
                      .where("type <> 'ProductionHistory'")
                      .order(happened_at: :asc)
                      .order(mileage: :asc)

      if start_date.present?
        @_histories = @_histories.where("happened_at >= :start_date", { start_date: start_date })
      end

      @_histories
    end
  end
end

class NullHistory
  def happened_at
    Time.now
  end

  def cost
    0
  end

  def mileage
    0
  end
end
