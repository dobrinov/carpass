class HistoryMailer < ApplicationMailer
  def notify_annual_inspection_history_expiration(history)
    @history = history
    @car = @history.car
    user = @car.user

    mail(to: user.email, subject: 'Изтичащ годишен технически преглед')
  end

  def notify_compulsory_insurance_history_expiration(history)
    @history = history
    @car = @history.car
    user = @car.user

    mail(to: user.email, subject: 'Изтичаща застраховка "Гражданска отговорност"')
  end

  def notify_full_insurance_history_expiration(history)
    @history = history
    @car = @history.car
    user = @car.user

    mail(to: user.email, subject: 'Изтичаща застраховка "Каско"')
  end
end
