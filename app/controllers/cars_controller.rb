class CarsController < ApplicationController
  before_action :requires_login

  def index
    @cars = current_user.cars

    redirect_to car_path(@cars.first) if @cars.any?
  end

  def show
    @cars = current_user.cars
    @car = @cars.find(params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    @car = current_user.cars.build(car_params)

    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def car_params
    if params[:car].present?
      params[:car].permit(:plate, :vin, :engine_number)
    else
      {}
    end
  end
end
