class SessionsController < ApplicationController
  before_action :set_referrer, only: [:create]

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.update_attribute(:last_login_at, Time.now)
    session[:user_id] = user.id
    redirect_to back_or_default, notice: 'Signed in'
  end

  def destroy
    session[:user_id] = nil
    redirect_to back_or_default, notice: "Signed out!"
  end

  protected

  def default_path
    root_path
  end

  private

  def set_referrer
    if env["omniauth.params"].present? && env["omniauth.params"]["referrer"].present?
      params[:referrer] = env["omniauth.params"]["referrer"]
    end
  end
end
