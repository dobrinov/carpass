class ExpiringAnnualInspectionHistoryNotification < Notification
  def deliver
    HistoryMailer.
      notify_annual_inspection_history_expiration(history).
      deliver_now
  end

  def history
    notifiable
  end

  def car
    history.car
  end
end
