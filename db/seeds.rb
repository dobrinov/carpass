def create_user(email)
  password = '1'
  user = User.new email: 'homer@example.com',
                  password: password,
                  password_confirmation: password,
                  last_login_at: Time.current

  user.build_setting
  user.save! validate: false
  user
end

homer = create_user 'homer@example.com'

bmw = Brand.create! name: 'BMW'
car = Car.create! user: homer, brand: bmw, model: '325i', plate: 'CB1234XX'
