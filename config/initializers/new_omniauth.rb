$app_config = Hash.new
begin
  cfg=YAML::load_file(Rails.root.to_s+'/config/new_omniauth.yml')
  $app_config= cfg[Rails.env] if cfg.is_a?(Hash) and cfg.has_key?(Rails.env)
  $app_config.freeze
rescue
end

