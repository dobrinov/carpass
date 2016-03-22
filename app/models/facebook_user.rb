class FacebookUser
  def self.from_omniauth(auth)
    fetch_from_omniauth(auth) || create_from_omniauth(auth)
  end

  def self.fetch_from_omniauth(auth)
    User.where(provider: auth['provider'], uid: auth['uid']).first
  end

  def self.create_from_omniauth(auth)
    User.create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.password = (0...8).map { (65 + rand(26)).chr }.join
    end
  end
end
