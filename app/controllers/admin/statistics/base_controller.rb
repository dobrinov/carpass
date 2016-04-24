module Admin
  module Statistics
    class BaseController < Admin::BaseController
      def overview
        @all_users_count     = User.count
        @active_users_count  = History.where("type NOT IN('ProductionHistory', 'PurchaseHistory')")
                                      .includes(car: [:user])
                                      .map(&:car).map(&:user)
                                      .uniq.count
        @all_cars_count      = Car.count
        @all_histories_count = History.count
      end
    end
  end
end
