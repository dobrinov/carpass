module Admin
  module Statistics
    class UsersController < BaseController
      def signups
        @user_signups = ::Statistics::Chartjs::UserSignups.new(Date.today - 1.month, Date.today)
      end

      def signins
        @user_signins = ::Statistics::Chartjs::UserSignins.new(Date.today - 1.month, Date.today)
      end
    end
  end
end
