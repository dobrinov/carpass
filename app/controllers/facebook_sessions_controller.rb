class FacebookSessionsController < ApplicationController
  def create
    user = FacebookUser.from_omniauth(env["omniauth.auth"])
    log_in(user)
    redirect_to back_or_default
  end
end
