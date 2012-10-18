Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, $app_config["facebook"]["key"], $app_config["facebook"]["secret_key"], {:scope => 'email'}

end
