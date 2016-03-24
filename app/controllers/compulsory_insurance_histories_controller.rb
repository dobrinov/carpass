class CompulsoryInsuranceHistoriesController < HistoriesController
  def new
    @history = CompulsoryInsuranceHistory.new
  end

  def create
    @history = CompulsoryInsuranceHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:compulsory_insurance_history].present?
      params[:compulsory_insurance_history].permit(:mileage, :cost, :details)
    else
      {}
    end
  end
end
