class ExpiringAnnualInspectionHistoryFacebookNotification < FacebookNotification
  private

  def message
    "На #{notification.history.valid_until.strftime("%d.%m.%Y")} изтича 'Годишен технически преглед' на автомобил с регистрационен номер #{notification.car.plate}."
  end
end
