module Statistics
  module Chartjs
    class Base
      def labels
        fail "Implement in #{self.class.name}"
      end

      def datasets
        fail "Implement in #{self.class.name}"
      end
    end
  end
end
