RedBase::Engine.setup do |config|
  # Logger settings for RedBase.
  # Default value is the rails logger
  # config.logger = Logger.new(STDOUT)

  # Add your models which want to manage their permissions
  config.models_with_permission = []

  # Url prefix for dashboard section. default is '/dashboard'
  # config.dashboard_namespace = :dashboard
end
