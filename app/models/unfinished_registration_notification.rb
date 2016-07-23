class UnfinishedRegistrationNotification < Notification
  def deliver
    if user.setting.receives_inactivity_emails?
      UserMailer.
        unfinished_registration(user).
        deliver_now
    end

    if user.facebook_user? && user.setting.receives_inactivity_facebook_notifications?
      UnfinishedRegistrationFacebookNotification.deliver(self)
    end
  end
end
