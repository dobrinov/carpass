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

    protected

    def default_path
      car_path(@car)
    end
  end
end
