class HistoryExpirationNotifier
  attr_reader :logger

  def initialize
    @logger = Logger.new("#{Rails.root}/log/history_expiration_notifier.log", 'a')
  end

  def self.call
    new.call
  end

  def call
    logger.debug "Setting up emailing using password #{ENV['SENDGRID_PASSWORD']}"
    logger.info "Sending notifications about #{histories.count} histories."
    histories.each(&:notify_expiration)
  end

  private

  def histories
    History.where("DATE(valid_until) = ?", Date.today + 7.days)
  end
end
