class HistoryExpirationNotifier
  attr_reader :logger

  def initialize
    @logger = Logger.new("#{Rails.root}/log/history_expiration_notifier.log", File::APPEND)
  end

  def self.call
    new.call
  end

  def call
    logger.debug "Setting up emailing using password #{ENV['SENDGRID_PASSWORD']}"
    logger.info "Sending notifications about #{histories.count} histories."
    histories.each do |history|
      next unless history.notify_about_expiration?

      notification = history.expiration_notification_class.create!(
        user: history.car.user,
        notifiable: history
      )

      notification.deliver
    end
  end

  private

  def histories
    History.where("DATE(valid_until) = ?", Date.today + 7.days)
  end
end
