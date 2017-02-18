class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Helper methods
  helper_method \
    :current_user,
    :logged_in?

  private

  def log_in(user)
    user.update_attributes(last_login_at: Time.current, login_count: user.login_count + 1)
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

  def load_additional_javascript(script_attributes)
    @_additional_javascripts ||= []
    @_additional_javascripts << script_attributes
  end

  def load_map_javascript
    load_additional_javascript(
      {
        src: '//maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyAb89pIihEqO8YjxruvK4WSs3Bt37vuxPc&language=bg'
      }
    )
  end

  def load_map_clustering_javascript
    load_additional_javascript(
      {
        src: '//developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js'
      }
    )
  end
end
