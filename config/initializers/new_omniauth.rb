APP_CONFIG = Hash.new
begin
  cfg = YAML::load_file(Rails.root.to_s + '/config/new_omniauth.yml')
  APP_CONFIG = cfg[Rails.env] if cfg.is_a?(Hash) and cfg.has_key?(Rails.env)
  APP_CONFIG.freeze
rescue
end