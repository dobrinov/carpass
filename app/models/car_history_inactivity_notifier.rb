class CarHistoryInactivityNotifier
  attr_reader :logger, :period

  def initialize(period)
    @logger = Logger.new("#{Rails.root}/log/inactive_users_notifier.log", 'a')
    @period = period
  end

  def self.call
    new.call
  end

  def call
    # Implement me
  end

  private

  def notify(user)
    UserMailer.notify_inactivity(user).deliver_now
  end

  def users
    # Implement me
  end
end
