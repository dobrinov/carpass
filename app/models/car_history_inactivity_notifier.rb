class CarHistoryInactivityNotifier
  attr_reader :logger, :period

  def initialize(period)
    @logger = Logger.new("#{Rails.root}/log/car_history_inactivity_notifier.log", File::APPEND)
    @period = period
  end

  def self.call(period)
    new(period).call
  end

  def call
    logger.info("Sending notifications about #{cars.count} cars...")

    cars.each do |car|
      notification = CarHistoryInactivityNotification.create!(
        user: car.user,
        notifiable: car
      )

      notification.deliver
    end
  end

  private

  def cars
    cars = User.includes(:cars).where('last_login_at < ?', Date.today - period).
             map(&:cars).
             flatten

    # Remove cars for which notifications were sent recently (period)
    cars.reject do |car|
      car.user.notifications.
        where(type: CarHistoryInactivityNotification).
        where('created_at > ?', Date.today - period).
        any?
    end
  end
end
