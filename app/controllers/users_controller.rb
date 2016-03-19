class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.update_attribute(:last_login_at, Time.now)
      session[:user_id] = @user.id
      redirect_to back_or_default
    else
      render :new
    end
  end

  private

  def user_params
    if params[:user].present?
      params[:user].permit(:email, :password, :password_confirmation)
    else
      {}
    end
  end
end
