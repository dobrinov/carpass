class CarsController < ApplicationController
  before_action :requires_login

  def index
    @cars = current_user.cars

    redirect_to car_path(@cars.first) if @cars.any?
  end

  def show
    @cars = current_user.cars
    @car = @cars.find(params[:id])
    @histories = @car.histories.order(created_at: :desc)
  end

  def new
    @cars = current_user.cars
    @car = Car.new
  end

  def create
    @car = current_user.cars.build(car_params)

    @car.histories.build(created_at: params[:car][:produced_at], type: 'DateOfProduction')
    @car.histories.build(mileage: params[:car][:mileage_at_purchase], created_at: params[:car][:purchased_at], type: 'DateOfPurchase')

    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
    # To do
  end

  def update
    # To do
  end

  def destroy
    # To do
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
