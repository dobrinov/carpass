Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, AppConfig.facebook['key'], AppConfig.facebook['secret'],
  scope: 'public_profile,email',
  display: 'page',
  info_fields: 'id,email,location,first_name,last_name,gender,picture',
  :client_options => {
    :site => 'https://graph.facebook.com/v2.12',
    :authorize_url => "https://www.facebook.com/v2.12/dialog/oauth"
  },
  token_params: { parse: :json }
end
