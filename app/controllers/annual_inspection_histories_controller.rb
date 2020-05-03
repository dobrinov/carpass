class AnnualInspectionHistoriesController < HistoriesController
  def show
  end

  def new
    @history = AnnualInspectionHistory.new(mileage: @car.current_mileage)
  end

  def create
    @history = AnnualInspectionHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:annual_inspection_history].present?
      params[:annual_inspection_history].permit(:happened_at, :mileage, :valid_until, :cost, :details).to_h
    else
      {}
    end
  end
end
