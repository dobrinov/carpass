def create_user(email)
  password = '1'
  user = User.new email: 'homer@example.com', password: password, password_confirmation: password
  user.save! validate: false
  user
end

homer = create_user 'homer@example.com'
