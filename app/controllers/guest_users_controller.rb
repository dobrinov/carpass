class GuestUsersController < ApplicationController
  def create
    guest_user = GuestUser.create!

    log_in(guest_user)

    redirect_to root_path
  end
end
