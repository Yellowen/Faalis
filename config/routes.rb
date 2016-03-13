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

  localized_scope do
    in_dashboard do
      scope :auth do
        resources :groups, as: 'auth_groups'
        resources :users, as: 'auth_users' do
          member do
            get   'password', to: 'users#edit_password', as: 'auth_users_edit_password'
            patch 'password', to: 'users#update_password'
          end
        end
      end
      resources :user_messages
      get '', to: '/faalis/dashboard#index', as: 'index'
      get '/404', to: '/faalis/dashboard#not_found', as: 'not_found'
    end

    devise_config.merge!(Faalis::Engine.devise_for)
    devise_for :users, devise_config
  end

  #scope '(:locale)', locale: Regexp.new(::I18n.available_locales.join('|')) do
  #  scope Faalis::Engine.dashboard_namespace.to_sym do
      #get '' => 'dashboard#index', :as => 'dashboard'
  #    get 'modules' => 'dashboard#modules'
  #  end

  #devise_for :users, devise_config
  #end

  # match('/users/auth/:provider',
  #       constraints: { provider: /#{Devise.omniauth_configs.keys.join("|")}/ },
  #       controller: "devise/omniauth_callbacks#passthru",
  #       as: :user_omniauth_authorize,
  #       via: [:get, :post])

  # match('/users/auth/:action/callback',
  #       constraints: { action: /#{Devise.omniauth_configs.keys.join("|")}/ },
  #       controller: 'devise/omniauth_callbacks',
  #       as: :user_omniauth_callback,
  #       via: [:get, :post])

end
