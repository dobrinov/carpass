class CompulsoryInsuranceHistory < History
  def notify_expiration
    HistoryMailer.notify_compulsory_insurance_history_expiration(self).deliver_now
  end
end
