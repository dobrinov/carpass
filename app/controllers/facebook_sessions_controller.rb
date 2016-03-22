class FacebookSessionsController < ApplicationController
  def create
    user = FacebookUser.from_omniauth(env["omniauth.auth"])
    log_in(user)
    redirect_to back_or_default
  end

  protected

  def default_path
    cars_path
  end
end
