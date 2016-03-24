class TyreHistoriesController < HistoriesController
  def new
    @history = TyreHistory.new
  end

  def create
    @history = TyreHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:tyre_history].present?
      params[:tyre_history].permit(:mileage, :details)
    else
      {}
    end
  end
end
