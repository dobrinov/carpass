class UnfinishedRegistrationsNotifier
  attr_reader :logger, :period

  def initialize(period)
    @logger = Logger.new("#{Rails.root}/log/unfinished_registrations_notifier.log", File::APPEND)
    @period = period
  end

  def self.call(period)
    new(period).call
  end

  def call
    logger.info("Sending notifications to #{users.count} users...")

    users.each do |user|
      logger.info("Sending notification to #{user.email}")
      notification = UnfinishedRegistrationNotification.create!(
        user: user,
        notifiable: user
      )

      notification.deliver
    end
  end

  private

  def users
    users = User.
      includes(:cars).
      where( cars: { id: nil }).
        where('last_login_at < ?', Date.today - period)

    users.reject do |user|
      user.notifications.
        where(type: UnfinishedRegistrationNotification).
        any?
    end
  end
end
