class AnnualInspectionHistory < History
  def notify_expiration
    HistoryMailer.notify_annual_inspection_history_expiration(self).deliver_now
  end
end
