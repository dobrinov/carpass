Rails.application.config.middleware.use OmniAuth::Builder do

  if Rails.env.production?
    facebook_key    = ENV['FACEBOOK_KEY']
    facebook_secret = ENV['FACEBOOK_SECRET']
  else
    facebook_key    = 521198641395119
    facebook_secret = 'a59f0a3c0e9f16f87f066e097a846966'
  end

  provider :facebook, facebook_key, facebook_secret, scope: 'email', display: 'page'
  # client_options: {
  #   site: 'https://graph.facebook.com/v2.3',
  #   authorize_url: "https://www.facebook.com/v2.3/dialog/oauth"
  # }
end
