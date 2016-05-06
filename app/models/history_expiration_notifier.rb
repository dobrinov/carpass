class HistoryExpirationNotifier
  def self.call
    new.call
  end

  def call
    histories.each(&:notify_expiration)
  end

  private

  def histories
    History.where("DATE(valid_until) = ?", Date.today + 7.days)
  end
end
