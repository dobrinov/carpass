module Admin
  module Statistics
    class CarsController < BaseController
      def creations
        @car_creations = ::Statistics::CarCreations.new(Date.today - 1.month, Date.today)
      end
    end
  end
end
