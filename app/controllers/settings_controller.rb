class SettingsController < ApplicationController
  before_action :requires_login

  def edit
    @setting = current_user.setting
  end

  def update
    @setting = current_user.setting

    if @setting.update_attributes(setting_params)
      redirect_to settings_path, notice: 'Настройките бяха успешно променени.'
    else
      render :edit
    end
  end

  private

  def setting_params
    if params[:setting].present?
      params[:setting].permit(
        :receives_history_expiration_emails,
        :receives_inactivity_emails,
        :receives_history_expiration_facebook_notifications,
        :receives_inactivity_facebook_notifications
      ).to_h
    else
      {}
    end
  end
end
