class PasswordsController < ApplicationController
  before_action :requires_login, only: [:edit, :update]

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(password_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def password_params
    if params[:user].present?
      params[:user].permit(:password, :password_confirmation)
    else
      {}
    end
  end
end
