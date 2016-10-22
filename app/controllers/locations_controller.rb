class LocationsController < ApplicationController
  before_action :load_map_clustering_javascript, only: [:index]
  before_action :load_map_javascript, only: [:index]

  def index
    @locations = if params[:approved_for_map]
                   Location.approved_for_map
                 else
                   Location.all.order(settlement: :asc)
                 end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @location = Location.find params[:id]

    respond_to do |format|
      format.json
    end
  end
end
