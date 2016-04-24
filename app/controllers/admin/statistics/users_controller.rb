module Admin
  module Statistics
    class UsersController < BaseController
      def overview
      end

      def signups
        @signups = User.where("created_at >= :registration_date AND created_at <= :today", { registration_date: Date.today - 1.month, today: Date.today })
                       .select("date(created_at) as date, count(*) as signups")
                       .group("date(created_at)")
      end
    end
  end
end
