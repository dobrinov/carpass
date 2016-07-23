class ExpiringFullInsuranceHistoryNotification < Notification
  def deliver
    if user.setting.receives_history_expiration_emails?
      HistoryMailer.
        notify_full_insurance_history_expiration(history).
        deliver_now
    end

    if user.facebook_user? && user.setting.receives_inactivity_facebook_notifications?
      ExpiringFullInsuranceHistoryFacebookNotification.deliver(self)
    end
  end

  def history
    notifiable
  end

  def car
    history.car
  end
end
