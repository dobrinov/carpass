module Admin
  module Statistics
    class UsersController < BaseController
      def signups
        @user_signups = ::Statistics::UserSignups.new(Date.today - 1.month, Date.today)
      end

      def signins
        @user_signins = ::Statistics::UserSignins.new(Date.today - 1.month, Date.today)
      end
    end
  end
end
