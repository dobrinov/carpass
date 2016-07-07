class CarMailer < ApplicationMailer
  def car_history_inactivity(car)
    @car = car
    user = @car.user

    mail(to: user.email, subject: 'Случвало ли се е нещо ново с колата ти?')
  end
end

