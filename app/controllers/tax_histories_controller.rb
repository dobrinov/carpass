class TaxHistoriesController < HistoriesController
  def new
    @history = TaxHistory.new
  end

  def create
    @history = TaxHistory.new(history_params.merge(car_id: @car.id))

    if @history.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def history_params
    if params[:tax_history].present?
      params[:tax_history].permit(:mileage, :valid_until, :cost, :details)
    else
      {}
    end
  end
end
