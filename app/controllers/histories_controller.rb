class HistoriesController < ApplicationController
  before_action :requires_login

  def new
    @cars = current_user.cars
    @car = @cars.find(params[:car_id])
    @histories = @car.histories.order(created_at: :desc)
    @history = History.new
  end

  def create
    @cars = current_user.cars
    @car = @cars.find(params[:car_id])
    @histories = @car.histories.order(created_at: :desc)
    @history = History.new(history_params.merge(car_id: @car.id))

    if @history.save
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

  protected

  def default_path
    cars_path
  end

  private

  def history_params
    if params[:history].present?
      params[:history].permit(:mileage, :details)
    else
      {}
    end
  end
end
