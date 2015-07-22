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

  localized_scop do
    in_dashboard do
      get  'auth/groups/new', to: 'groups#new'
      get  'auth/groups/:id', to: 'groups#edit', as: 'auth_groups_edit'
      post 'auth/groups',     to: 'groups#create'
      put  'auth/groups/:id', to: 'groups#update', as: 'auth_groups_update'

      get  'auth/users',     to: 'users#index'
      get  'auth/users/new', to: 'users#new'
      get  'auth/users/:id', to: 'users#show', as: 'auth_users_show'
      get  'auth/users/:id/edit', to: 'users#edit', as: 'auth_users_edit'
      post 'auth/users',     to: 'users#create'
      put  'auth/users/:id', to: 'users#update', as: 'auth_users_update'
      get('auth/users/:id/password', to: 'users#edit_password',
          as: 'auth_users_edit_password')

      patch 'auth/users/:id/password', to: 'users#update_password'
      delete  'auth/users/:id', to: 'users#destroy', as: 'auth_users_destroy'

      get '', to: 'dashboard#index', as: 'dashboard'
      get '/404', to: 'dashboard#not_found', as: 'not_found'
    end

    devise_for :users, devise_config
  end

  #scope '(:locale)', locale: Regexp.new(::I18n.available_locales.join('|')) do
  #  scope Faalis::Engine.dashboard_namespace.to_sym do
      #get '' => 'dashboard#index', :as => 'dashboard'
  #    get 'modules' => 'dashboard#modules'
  #  end

  #devise_for :users, devise_config
  #end

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
