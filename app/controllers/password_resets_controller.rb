class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset_token if user
    redirect_to signin_path, notice: "На посочения адрес беше изпратен имейл с инструкции."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:token])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:token])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: 'Сесията е изтекла.'
    end

    if @user.update_attributes(user_params)
      redirect_to signin_path, notice: 'Паролата бе променена.'
    else
      render :edit
    end
  end

  private

  def user_params
    if params[:user].present?
      params[:user].permit(:password, :password_confirmation)
    else
      {}
    end
  end
end
