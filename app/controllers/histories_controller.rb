class HistoriesController < ApplicationController
  before_action :requires_login
  before_action :set_instance_variables

  protected

  def default_path
    cars_path
  end

  private

  def set_instance_variables
    @cars = current_user.cars
    @car  = @cars.find(params[:car_id])
  end
end
