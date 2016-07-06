class ExpiringFullInsuranceHistoryNotification < Notification
  def deliver
    HistoryMailer.
      notify_full_insurance_history_expiration(history).
      deliver_now
  end

  def history
    notifiable
  end

  def car
    history.car
  end
end
