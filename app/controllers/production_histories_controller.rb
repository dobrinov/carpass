class ProductionHistoriesController < HistoriesController
  def show
  end

  private

  def history_params
    # if params[:full_insurance_history].present?
    #   params[:full_insurance_history].permit(:mileage, :valid_until, :cost, :details)
    # else
    #   {}
    # end
  end
end
