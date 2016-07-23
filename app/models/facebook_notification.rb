require 'httparty'
require 'json'

class FacebookNotification
  include HTTParty

  attr_reader :notification

  base_uri 'https://graph.facebook.com'

  def self.access_token(notification)
    new(notification).access_token
  end

  def self.deliver(notification)
    new(notification).deliver
  end

  def initialize(notification)
    @notification = notification
  end

  def access_token
    response = self.class.get("/oauth/access_token?client_id=#{AppConfig.facebook['key']}&client_secret=#{AppConfig.facebook['secret']}&grant_type=client_credentials")

    response.body.split('=')[1]
  end

  def deliver
    response = self.class.post("/#{notification.user.uid}/notifications?access_token=#{access_token}&template=#{URI::encode(message)}&href=/facebook/notifications/#{notification.id}")

    JSON.parse(response.body)['success']
  end

  private

  def message
    raise 'This method should be implemented in child class.'
  end
end
