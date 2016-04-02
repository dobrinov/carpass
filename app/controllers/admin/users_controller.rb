module Admin
  class UsersController < BaseController
    def index
      @users = User.all.order(created_at: :desc)
    end
  end
end
