module Admin
  class LocationsController < BaseController
    before_action :load_map_javascript

    def index
      @tab = Tab.new params[:tab]
      @locations_with_geodata = Location.with_defined_geolocation.order(settlement_type: :asc)
      @locations_without_geodata = Location.with_default_geolocation.order(settlement_type: :asc)


      @locations = if @tab.with_geodata?
                     @locations_with_geodata
                   else
                     @locations_without_geodata
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
        permit(:name, :settlement, :settlement_type, :address, :longitude, :latitude)
    end
  end

  class Tab
    def initialize(name)
      if name == 'without_geodata'
        @with_geodata = false
      else
        @with_geodata = true
      end
    end

    def with_geodata?
      @with_geodata
    end
  end
end
