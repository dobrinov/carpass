class ExpiringFullInsuranceHistoryFacebookNotification < FacebookNotification
  private

  def message
    "На #{notification.history.valid_until.strftime("%d.%m.%Y")} изтича застраховка 'Каско' на автомобил с регистрационен номер #{notification.car.plate}."
  end
end
