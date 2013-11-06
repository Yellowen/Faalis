RedBase::Engine.routes.draw do

  scope "(:locale)", :locale => Regexp.new(::I18n.available_locales.join("|")) do
    scope RedBase::Engine.dashboard_namespace.to_sym do
      get "" => "dashboard#index"
      get "modules" => "dashboard#modules"
    end

    # Authentications
    devise_for :users, {
      :class_name => "RedBase::User",
      :controllers => { :omniauth_callbacks => "red_base/omniauth/callbacks" },
      :module => :devise
    }

    # Root URL
    root :to => "home#index"
  end

  mount RedBase::API => "api"
end
