class HistoriesController < ApplicationController
  before_action :requires_login
  before_action :set_car_instance_variables,    only: [:new, :create]
  before_action :set_history_instance_variable, only: [:show, :edit, :update, :destroy]

  def show
    case @history
    when AnnualInspectionHistory
      redirect_to annual_inspection_history_path(@history, referrer_param => back_or_default)
    when CompulsoryInsuranceHistory
      redirect_to compulsory_insurance_history_path(@history, referrer_param => back_or_default)
    when PurchaseHistory
      redirect_to purchase_history_path(@history, referrer_param => back_or_default)
    when ProductionHistory
      redirect_to production_history_path(@history, referrer_param => back_or_default)
    when FullInsuranceHistory
      redirect_to full_insurance_history_path(@history, referrer_param => back_or_default)
    when MaintenanceHistory
      redirect_to maintenance_history_path(@history, referrer_param => back_or_default)
    when RepairmentHistory
      redirect_to repairment_history_path(@history, referrer_param => back_or_default)
    when TaxHistory
      redirect_to tax_history_path(@history, referrer_param => back_or_default)
    when TuningHistory
      redirect_to tuning_history_path(@history, referrer_param => back_or_default)
    when TyreHistory
      redirect_to tyre_history_path(@history, referrer_param => back_or_default)
    when VignetteHistory
      redirect_to vignette_history_path(@history, referrer_param => back_or_default)
    else
      redirect_to back_or_default
    end
  end

  def edit
  end

  def update
    if @history.update_attributes(history_params)
      redirect_to back_or_default
    else
      render :edit
    end
  end

  def destroy
    @history.destroy
    redirect_to back_or_default
  end

  protected

  def default_path
    if referrer_path
      referrer_path
    elsif @history && @history.car
      car_path(@history.car)
    else
      cars_path
    end
  end

  private

  def history_params
    {}
  end

  def set_history_instance_variable
    @history = current_user.histories.find(params[:id])
    @cars = current_user.cars
    @car  = @history.car
  end

  def set_car_instance_variables
    @cars = current_user.cars
    @car  = @cars.find(params[:car_id])
  end
end
