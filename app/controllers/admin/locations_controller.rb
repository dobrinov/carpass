module Admin
  class LocationsController < BaseController
    before_action :load_map_javascript, only: [:new, :edit]

    def index
      @tab = Tab.new params[:tab]
      @locations_approved_for_map = Location.approved_for_map.order(settlement: :asc)
      @locations_not_approved_for_map = Location.not_approved_for_map.order(settlement: :asc)
      @unprocessed_locations = Location.unprocessed.order(settlement: :asc)

      @locations = if @tab.approved_for_map?
                     @locations_approved_for_map
                   elsif @tab.not_approved_for_map?
                     @locations_not_approved_for_map
                   else
                     @unprocessed_locations
                   end
    end

    def show
    end

    def new
      @location = Location.new(latitude: Bulgaria::LATITUDE, longitude: Bulgaria::LONGITUDE)
    end

    def create
      @location = Location.new(location_params)

      if @location.save
        redirect_to admin_locations_path
      else
        render :new
      end
    end

    def edit
      @location = Location.find(params[:id])
    end

    def update
      @location = Location.find(params[:id])

      if @location.update_attributes(location_params)
        redirect_to admin_locations_path
      else
        render :edit
      end
    end

    def destroy
      location = Location.find(params[:id])
      location.destroy
      redirect_to admin_locations_path
    end

    private

    def location_params
      params.
        require(:location).
        permit(:name, :settlement, :settlement_type, :status, :address, :longitude, :latitude)
    end
  end

  class Tab
    def initialize(name)
      @approved_for_map = false
      @not_approved_for_map = false
      @unprocessed = false

      if name == 'approved_for_map'
        @approved_for_map = true
      elsif name == 'not_approved_for_map'
        @not_approved_for_map = true
      else
        @unprocessed = true
      end
    end

    def approved_for_map?
      @approved_for_map
    end

    def not_approved_for_map?
      @not_approved_for_map
    end

    def unprocessed?
      @unprocessed
    end
  end
end
