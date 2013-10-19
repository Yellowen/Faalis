module RedBase
  module Omniauth
    class CallbacksController < Devise::OmniauthCallbacksController

      def facebook

        create_or_find_user

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end

      def google_oauth2
        raise "asdad<"
      end
      include RedBase::Omniauth::Callbacks
    end
  end
end
