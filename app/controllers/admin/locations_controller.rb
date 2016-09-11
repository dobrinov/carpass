module Admin
  class LocationsController < BaseController
    before_action :load_map_javascript

    def index
      @locations = Location.all
    end

    def show
    end

    def new
      @location = Location.new(latitude: Bulgaria::LATITUDE, longitude: Bulgaria::LONGITUDE, zoom_level: Bulgaria::ZOOM_LEVEL)
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
        permit(:name, :city, :address, :details, :type, :longitude, :latitude, :zoom_level)
    end
  end
end
