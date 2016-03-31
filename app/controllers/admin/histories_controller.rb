module Admin
  class HistoriesController < BaseController
    def index
      @car = Car.find(params[:car_id])
      @histories = @car.histories
    end
  end
end
