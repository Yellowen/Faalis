module Devise
  @@omniauth_service_providers

  def self.omniauth_service_providers(*args)
    @@omniauth_service_providers = args
  end

  def self.omniauth__providers_list
    @@omniauth_service_providers
  end
end
