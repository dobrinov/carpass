class AnnualInspectionHistoriesController < HistoriesController
  def show
  end

  def new
    @history = AnnualInspectionHistory.new
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
      params[:annual_inspection_history].permit(:mileage, :valid_until, :cost, :details)
    else
      {}
    end
  end
end
