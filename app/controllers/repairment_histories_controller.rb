class RepairmentHistoriesController < HistoriesController
  def show
  end

  def new
    @history = RepairmentHistory.new(mileage: @car.current_mileage)
  end

  def create
    @history = RepairmentHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:repairment_history].present?
      params[:repairment_history].permit(:happened_at, :mileage, :cost, :details).to_h
    else
      {}
    end
  end
end
