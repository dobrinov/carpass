class UsersController < ApplicationController
  before_action :requires_login, only: [:show, :edit, :update]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      UserMailer.welcome_email(@user).deliver_now
      redirect_to back_or_default
    else
      render :new
    end
  end

  private

  def user_params
    if params[:user].present?
      params[:user].permit(:email, :password, :password_confirmation, :first_name, :last_name)
    else
      {}
    end
  end
end
