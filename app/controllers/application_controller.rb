class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Helper methods
  helper_method \
    :current_user,
    :logged_in?

  private

  def log_in(user)
    user.update_attribute(:last_login_at, Time.current)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def logged_in?
    current_user.present?
  end

  def redirect_if_logged
    redirect_to root_path if logged_in?
  end

  def requires_login
    redirect_to signin_path(referrer_param => current_path) unless logged_in?
  end

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def parse_multi_parameter_datetime(params, name)
    DateTime.new(*(1..6).map { |i| params["#{name}(#{i}i)"].to_i })
  end
end
