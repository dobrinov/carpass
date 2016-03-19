class SessionsController < ApplicationController
  before_action :set_referrer, only: [:create]

  def new
  end

  def create
    if omniauth_session?
      user = User.from_omniauth(env["omniauth.auth"])
      user.update_attribute(:last_login_at, Time.now)
      session[:user_id] = user.id
      redirect_to back_or_default
    else
      user = User.where(email: params[:email]).first

      if UserAuthenticator.new(user).authenticate(params[:password])
        user.update_attribute(:last_login_at, Time.now)
        session[:user_id] = user.id
        redirect_to back_or_default
      else
        @invalid_credentials = true
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to back_or_default
  end

  protected

  def default_path
    cars_path
  end

  private

  def omniauth_session?
    env["omniauth.auth"].present?
  end

  def set_referrer
    if env["omniauth.params"].present? && env["omniauth.params"]["referrer"].present?
      params[:referrer] = env["omniauth.params"]["referrer"]
    end
  end
end
