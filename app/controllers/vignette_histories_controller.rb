class VignetteHistoriesController < HistoriesController
  def new
    @history = VignetteHistory.new
  end

  def create
    @history = VignetteHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:vignette_history].present?
      params[:vignette_history].permit(:mileage, :details)
    else
      {}
    end
  end
end
