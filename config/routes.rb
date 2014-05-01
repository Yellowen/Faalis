Faalis::Engine.routes.draw do
  get 'templates/*path' => 'dashboard#jstemplate'

  # Authentications
  devise_config = {
    :class_name => 'Faalis::User',
    :module => :devise
  }

  # Add omniauth callback if there was any provider
  unless Devise.omniauth_providers.empty?
    devise_config[:controllers] = {
      :omniauth_callbacks => 'faalis/omniauth/callbacks',
    }
  end

  devise_for :users, devise_config


  scope '(:locale)', :locale => Regexp.new(::I18n.available_locales.join('|')) do
    scope Faalis::Engine.dashboard_namespace.to_sym do
      get '' => 'dashboard#index', :as => 'dashboard'
      get 'modules' => 'dashboard#modules'
    end


    # Root URL
    root :to => 'home#index'
  end


end
