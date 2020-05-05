class FullInsuranceHistoriesController < HistoriesController
  def show
  end

  def new
    @history = FullInsuranceHistory.new(mileage: @car.current_mileage)
  end

  def create
    @history = FullInsuranceHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:full_insurance_history].present?
      params[:full_insurance_history].permit(:happened_at, :mileage, :valid_until, :cost, :details).to_h
    else
      {}
    end
  end
end
