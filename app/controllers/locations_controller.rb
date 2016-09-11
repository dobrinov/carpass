class LocationsController < ApplicationController
  def index
    redirect_to locations_annual_inspection_path
  end

  def annual_inspection
  end
end
