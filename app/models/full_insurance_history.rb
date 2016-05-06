class FullInsuranceHistory < History
  def notify_expiration
    HistoryMailer.notify_full_insurance_history_expiration(self).deliver_now
  end
end
