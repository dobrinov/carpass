module Facebook
  class NotificationsController < ApplicationController
    layout 'facebook_canvas'

    skip_before_action :verify_authenticity_token

    before_action :parse_signed_request
    before_action :requires_login
    before_action :allow_iframe_requests

    def show
      @notification = current_user.notifications.find(params[:id])
    end

    private

    def current_user
      if params[:facebook][:user_id]
        User.where(uid: params[:facebook][:user_id]).first
      end
    end

    def requires_login
      redirect_to root_path unless current_user.present?
    end

    def parse_signed_request
      encoded_signature, payload = params[:signed_request].split('.')
      params[:facebook] = JSON.parse(Base64.decode64(payload))
    end

    def allow_iframe_requests
      response.headers.delete('X-Frame-Options')
    end
  end
end
