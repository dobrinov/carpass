class UnfinishedRegistrationNotification < Notification
  def deliver
    UserMailer.
      unfinished_registration(user).
      deliver_now
  end
end
