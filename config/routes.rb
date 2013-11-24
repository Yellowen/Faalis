RedBase::Engine.routes.draw do

  # Authentications
  devise_for :users, {
    :class_name => "RedBase::User",
    :controllers => { :omniauth_callbacks => "red_base/omniauth/callbacks" },
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

  mount ::API::ApplicationAPI => "api"


end
