RedBase::Engine.routes.draw do

  # Authentications
  devise_for :users, :class_name => "RedBase::User"

  # Root URL
  root :to => "home#index"
end
