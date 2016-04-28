module Statistics
  class ExpensesController < ApplicationController
    before_action :requires_login

    def all_time
      @cars = current_user.cars
      @car = @cars.find(params[:car_id])
      @car_statistics = Statistics::CarStatistics.new(@car)
    end

    def last_year
      @cars = current_user.cars
      @car = @cars.find(params[:car_id])
      @car_statistics = Statistics::CarStatistics.new(@car, Date.today - 1.year)
    end

    def cost_by_month
      @cars = current_user.cars
      @car = @cars.find(params[:car_id])

      if params[:last_year]
        @car_statistics = Statistics::Chartjs::CarExpensesByMonth.new(@car, Date.today - 1.year)
      else
        @car_statistics = Statistics::Chartjs::CarExpensesByMonth.new(@car)
      end
    end

    def cost_by_type
      @cars = current_user.cars
      @car = @cars.find(params[:car_id])

      if params[:last_year]
        @car_statistics = Statistics::Chartjs::CarExpensesByType.new(@car, Date.today - 1.year)
      else
        @car_statistics = Statistics::Chartjs::CarExpensesByType.new(@car)
      end
    end

    protected

    def default_path
      car_path(@car)
    end
  end
end
