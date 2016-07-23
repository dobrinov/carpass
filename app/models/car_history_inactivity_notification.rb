class CarHistoryInactivityNotification < Notification
  def deliver
    if user.setting.receives_inactivity_emails?
      CarMailer.
        car_history_inactivity(car).
        deliver_now
    end

    if user.facebook_user? && user.setting.receives_inactivity_facebook_notifications?
      CarHistoryInactivityFacebookNotification.deliver(self)
    end
  end

  def car
    notifiable
  end
end
