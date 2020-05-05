class SessionsController < ApplicationController
  before_action :redirect_if_logged, only: [:new, :create]
  before_action :set_referrer, only: [:create]

  def new
  end

  def create
    user = User.where(email: params[:email]).first

    if UserAuthenticator.new(user).authenticate(params[:password])
      log_in(user)
      redirect_to back_or_default
    else
      @invalid_credentials = true
      render :new
    end
  end

  def destroy
    log_out
    redirect_to back_or_default
  end

  protected

  def default_path
    cars_path
  end

  private

  def omniauth_session?
    request.env["omniauth.auth"].present?
  end

  def set_referrer
    if request.env["omniauth.params"].present? && request.env["omniauth.params"]["referrer"].present?
      params[:referrer] = request.env["omniauth.params"]["referrer"]
    end
  end
end
