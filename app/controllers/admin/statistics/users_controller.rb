module Admin
  module Statistics
    class UsersController < BaseController
      def overview
      end

      def signups
        @user_signups = ::Statistics::UserSignups.new(Date.today - 1.month, Date.today)
      end
    end
  end
end
