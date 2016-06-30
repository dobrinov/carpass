class FullInsuranceHistory < History
  validates :valid_until, presence: true

  def notify_expiration
    HistoryMailer.notify_full_insurance_history_expiration(self).deliver_now
  end
end
