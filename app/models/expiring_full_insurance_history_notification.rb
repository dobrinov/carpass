class ExpiringFullInsuranceHistoryNotification < Notification
  def deliver
    if user.setting.receives_history_expiration_emails?
      HistoryMailer.
        notify_full_insurance_history_expiration(history).
        deliver_now
    end
  end

  def history
    notifiable
  end

  def car
    history.car
  end
end