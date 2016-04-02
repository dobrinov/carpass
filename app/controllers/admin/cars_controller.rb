module Admin
  class CarsController < BaseController
    def index
      @user = User.find(params[:user_id])
      @cars = @user.cars.order(created_at: :desc)
    end
  end
end
