module Statistics
  class CarStatistics
    attr_reader :car, :start_date, :end_date

    def initialize(car, start_date=nil)
      @car = car

      @start_date = start_date || first_car_history_date
      @end_date = Date.today
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

    private

    def first_car_history_date
      history = @car.histories.order(happened_at: :asc).order(mileage: :asc).first

      if history.present?
        Date.parse(history.happened_at.to_s)
      else
        Date.today
      end
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
        @_histories = @_histories.where("happened_at >= :start_date", { start_date: start_date.beginning_of_month })
      end

      @_histories
    end

    def months_in_time_interval
      (end_date - start_date).to_i / (1.month / 1.day)
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
end
