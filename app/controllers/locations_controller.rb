class LocationsController < ApplicationController
  def index
    @locations = Location.all.order(settlement: :asc)
  end
end
