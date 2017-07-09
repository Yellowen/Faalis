Faalis::Engine.routes.draw do
  devise_for :users, class_name: "Faalis::User"
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
      resources :user_messages do
        collection do
          get 'sent', to: 'user_messages#sent', as: :sent
        end
      end
      get '', to: '/faalis/dashboard#index', as: 'index'
      get '/404', to: '/faalis/dashboard#not_found', as: 'not_found'
    end

    devise_config.merge!(Faalis::Engine.devise_for)
    devise_for :users, devise_config
  end

  #get '/amd/*asset', to: 'assets#finder'
end
