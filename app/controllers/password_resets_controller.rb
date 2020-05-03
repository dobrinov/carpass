class PasswordResetsController < ApplicationController
  before_action :redirect_if_token_is_expired, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset_token if user
    redirect_to signin_path, notice: "На посочения адрес беше изпратен имейл с инструкции."
  end

  def edit
    @user = user_from_token
  end

  def update
    @user = user_from_token

    if @user.update_attributes(user_params)
      redirect_to signin_path, notice: 'Паролата бе променена.'
    else
      render :edit
    end
  end

  private

  def user_from_token
    @_user ||= User.find_by_password_reset_token(params[:token])
  end

  def redirect_if_token_is_expired
    @user = user_from_token

    if @user.present? && @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: 'Кодът за промяна на парола е изтекъл. Изпратете нов като посочите имейл.'
    end
  end

  def user_params
    if params[:user].present?
      params[:user].permit(:password, :password_confirmation).to_h
    else
      {}
    end
  end
end
