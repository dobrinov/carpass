module Admin
  class UsersController < BaseController
    def index
      @users = User.all.order(last_login_at: :desc)
    end
  end
end
