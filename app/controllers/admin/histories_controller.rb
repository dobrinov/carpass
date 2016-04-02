module Admin
  class HistoriesController < BaseController
    def index
      @car = Car.find(params[:car_id])
      @histories = @car.histories.order(created_at: :desc)
    end
  end
end
