class PurchaseHistoriesController < HistoriesController
  def show
  end

  private

  def history_params
    if params[:purchase_history].present?
      params[:purchase_history].permit(:happened_at, :mileage).to_h
    else
      {}
    end
  end
end
