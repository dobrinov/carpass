class CarHistoryInactivityNotification < Notification
  def deliver
    CarMailer.
      car_history_inactivity(car).
      deliver_now
  end

  def car
    notifiable
  end
end
