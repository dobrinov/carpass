class AnnualInspectionHistory < History
  validates :valid_until, presence: true

  def expiration_notification_class
    ExpiringAnnualInspectionHistoryNotification
  end
end
