Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, APP_CONFIG['facebook']['key'], APP_CONFIG['facebook']['secret_key'], { scope: 'email' }

end
