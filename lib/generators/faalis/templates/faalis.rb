Faalis::Engine.setup do |config|
  # Logger settings for Faalis.
  # Default value is the rails logger
  # config.logger = Logger.new(STDOUT)

  config.orm = 'active_record'

  # Add your models which want to manage their permissions
  config.models_with_permission = ['Faalis::Permissions::Auth']

  # Url prefix for dashboard section. default is '/dashboard'
  # config.dashboard_namespace = :dashboard
end
