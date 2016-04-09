class ProductionHistoriesController < HistoriesController
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
    if params[:production_history].present?
      params[:production_history].permit(:happened_at)
    else
      {}
    end
  end
end
