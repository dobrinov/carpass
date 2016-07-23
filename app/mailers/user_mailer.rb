class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Успешна регистрация')
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: 'Забравена парола')
  end

  def rebranding(user)
    @user = user
    mail(to: user.email, subject: 'Autobook.bg става Carpass.bg')
  end

  def unfinished_registration(user)
    @user = user
    mail(to: user.email, subject: 'Не си довършил регистрацията си в Carpass.bg')
  end
end
