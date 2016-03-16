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
    @car_creator = CarCreator.new(car_creator_params)
  end

  def create
    @cars = current_user.cars
    @car_creator = CarCreator.new(car_creator_params)

    if @car_creator.save
      redirect_to car_path(@car_creator.car)
    else
      raise @car_creator.errors.messages.inspect
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
    car = current_user.cars.find(params[:id])
    car.destroy
    redirect_to cars_path
  end

  private

  def car_creator_params
    if params[:car_creator].present?
      params[:car_creator].permit(:plate, :vin, :engine_number, :mileage_at_purchase).merge!({
        user:         current_user,
        produced_at:  parse_multi_parameter_datetime(params[:car_creator], :produced_at),
        purchased_at: parse_multi_parameter_datetime(params[:car_creator], :purchased_at)
      })
    else
      {}
    end
  end
end
