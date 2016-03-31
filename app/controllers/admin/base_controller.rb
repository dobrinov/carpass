module Admin
  class BaseController < ::ApplicationController
    before_action :requires_login

    before_action do
      redirect_to root_path unless logged_in? && current_user.admin?
    end

    layout 'admin'
  end
end
