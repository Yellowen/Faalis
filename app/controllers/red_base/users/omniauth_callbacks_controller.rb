module RedBase
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    Include RedBase::Omniauth::Callbacks
  end
end
