class TuningHistoriesController < HistoriesController
  def show
  end

  def new
    @history = TuningHistory.new
  end

  def create
    @history = TuningHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:tuning_history].present?
      params[:tuning_history].permit(:happened_at, :mileage, :cost, :details)
    else
      {}
    end
  end
end
