class CarHistoryInactivityFacebookNotification < FacebookNotification
  private

  def message
    "Повече от 2 месеца не са въвеждани данни за автомобил с регистрационен номер #{notification.car.plate}. Има ли нещо което си пропуснал да добавиш?"
  end
end
