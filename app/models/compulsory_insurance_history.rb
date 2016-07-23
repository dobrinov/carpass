class CompulsoryInsuranceHistory < History
  validates :valid_until, presence: true

  def expiration_notification_class
    ExpiringCompulsoryInsuranceHistoryNotification
  end
end
