module Admin
  class CarsController < BaseController
    def index
      if params[:user_id].present?
        @user = User.find(params[:user_id])
        @cars = @user.cars.order(created_at: :desc)
      else
        @cars = Car.order(created_at: :desc)
      end
    end

    def edit
      @car = Car.find params[:id]
    end

    def update
      @car = Car.find params[:id]

      if @car.update_attributes(car_params)
        redirect_to admin_cars_path
      else
        render :edit
      end
    end

    private

    def car_params
      if params[:car].present?
        params[:car].permit(:brand_id)
      else
        {}
      end
    end
  end
end
