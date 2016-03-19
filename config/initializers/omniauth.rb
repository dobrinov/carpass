Rails.application.config.middleware.use OmniAuth::Builder do

  if Rails.env.production?
    facebook_key    = ENV['FACEBOOK_KEY']
    facebook_secret = ENV['FACEBOOK_SECRET']
  else
    facebook_key    = 211397485887858
    facebook_secret = '86a1175ebf2a7b3ac7a0fc0002a6a091'
  end

  provider :facebook, facebook_key, facebook_secret,
  scope: 'public_profile,email',
  display: 'page',
  info_fields: 'id,email,location,first_name,last_name,gender,picture',
  :client_options => {
    :site => 'https://graph.facebook.com/v2.5',
    :authorize_url => "https://www.facebook.com/v2.5/dialog/oauth"
  },
  token_params: { parse: :json }
end
