class CompulsoryInsuranceHistory < History
  validates :valid_until, presence: true

  def notify_expiration
    HistoryMailer.notify_compulsory_insurance_history_expiration(self).deliver_now
  end
end
