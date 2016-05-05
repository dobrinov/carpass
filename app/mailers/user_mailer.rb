class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Успешна регистрация')
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: 'Забравена парола')
  end
end
