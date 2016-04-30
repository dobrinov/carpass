module Query
  class CarHistories
    attr_reader :car, :start_date, :end_date

    def initialize(car, start_date=nil, end_date=nil)
      @car = car

      @start_date = start_date || first_car_history_date
      @end_date = end_date || Date.today
    end

    def first_with_mileage
      with_mileage.first || NullHistory.new
    end

    def last_with_mileage
      with_mileage.last || NullHistory.new
    end

    def inject(initial, &block)
      relation.inject(initial, &block)
    end

    def each(&block)
      relation.each(&block)
    end

    private

    def with_mileage
      relation.select { |h| h.mileage.present? }
    end

    def first_car_history_date
      history = car.histories
                 .where('cost IS NOT NULL')
                 .where('mileage IS NOT NULL')
                 .order(happened_at: :asc)
                 .order(mileage: :asc)
                 .first

      if history.present?
        Date.parse(history.happened_at.to_s)
      else
        Date.today
      end
    end

    def relation
      @_relation ||= car.histories
                      .where("happened_at >= :start_date", { start_date: start_date.beginning_of_month })
                      .where("happened_at <= :end_date",   { end_date:   end_date })
                      .where("type <> 'ProductionHistory'")
                      .order(happened_at: :asc)
                      .order(mileage: :asc)
    end
  end
end
