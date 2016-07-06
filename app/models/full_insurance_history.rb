class FullInsuranceHistory < History
  validates :valid_until, presence: true

  def expiration_notification_class
    ExpiringFullInsuranceHistoryNotification
  end
end
