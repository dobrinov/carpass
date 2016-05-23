class FacebookSessionsController < ApplicationController
  def create
    user = FacebookUser.from_omniauth(env["omniauth.auth"])

    if user_created_last_minute?(user)
      flash[:facebook_tracking] = 'signup'
    end

    log_in(user)
    redirect_to back_or_default
  end

  protected

  def default_path
    cars_path
  end

  private

  def user_created_last_minute?(user)
    user.created_at > Time.current - 1.minute
  end
end
