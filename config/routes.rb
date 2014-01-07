RedBase::Engine.routes.draw do
  get "templates/*path" => "dashboard#jstemplate"

  # Authentications
  devise_for :users, {
    :class_name => "RedBase::User",
    :controllers => {
      :omniauth_callbacks => "red_base/omniauth/callbacks",
    },
    :module => :devise
  }

  scope "(:locale)", :locale => Regexp.new(::I18n.available_locales.join("|")) do
    scope RedBase::Engine.dashboard_namespace.to_sym do
      get "" => "dashboard#index", :as => "dashboard"
      get "modules" => "dashboard#modules"
    end


    # Root URL
    root :to => "home#index"
  end


  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get "permissions", :to => "permissions#index"
      resources :groups, :except => [:new]
      resources :users, :except => [:new]
      resource :profile, :except => [:new, :destroy]
      get "logs" => "logs#index"
    end
  end


end
