class UnfinishedRegistrationNotification < Notification
  def deliver
    if user.setting.receives_inactivity_emails?
      UserMailer.
        unfinished_registration(user).
        deliver_now
    end
  end
end
