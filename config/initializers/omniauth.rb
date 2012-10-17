Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, '457831454258339', '050a65615343ea873843e36faffb8f11',
{:scope => 'email'}

end
