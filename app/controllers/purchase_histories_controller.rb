class PurchaseHistoriesController < HistoriesController
  def show
  end

  def update
    if @history.update_attributes(history_params)
      redirect_to back_or_default
    else
      render :edit
    end
  end

  private

  def history_params
    if params[:purchase_history].present?
      params[:purchase_history].permit(:happened_at, :mileage)
    else
      {}
    end
  end
end
