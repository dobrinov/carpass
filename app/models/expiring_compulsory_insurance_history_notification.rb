class ExpiringCompulsoryInsuranceHistoryNotification < Notification
  def deliver
    HistoryMailer.
      notify_compulsory_insurance_history_expiration(history).
      deliver_now
  end

  def history
    notifiable
  end

  def car
    history.car
  end
end
