Faalis::Engine.routes.draw do
  get 'templates/*path' => 'dashboard#jstemplate'

  # Authentications
  devise_config = {
    class_name: 'Faalis::User',
    :module =>  :devise,
    skip: :omniauth_callbacks
  }

  # Add omniauth callback if there was any provider
  unless Devise.omniauth_providers.empty?
    devise_config[:controllers] = {
      :omniauth_callbacks => 'faalis/omniauth/callbacks',
    }
  end

  scope '(:locale)', locale: Regexp.new(::I18n.available_locales.join('|')) do
    scope Faalis::Engine.dashboard_namespace.to_sym do
      get '' => 'dashboard#index', :as => 'dashboard'
      get 'modules' => 'dashboard#modules'
    end

    devise_for :users, devise_config
  end

  match('/users/auth/:provider',
        constraints: { provider: /#{Devise.omniauth_configs.keys.join("|")}/ },
        to: "devise/omniauth_callbacks#passthru",
        as: :user_omniauth_authorize,
        via: [:get, :post])

  match('/users/auth/:action/callback',
        constraints: { action: /#{Devise.omniauth_configs.keys.join("|")}/ },
        to: 'devise/omniauth_callbacks',
        as: :user_omniauth_callback,
        via: [:get, :post])

end
