module RedBase
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

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


    def default_service_callback
      puts ">>>>>> ", params
    end

    def method_missing(mname, *args, &block)
      if Devise.omniauth_providers.include? mname
        return default_service_callback
      else
        super
      end
    end

    private

    def create_or_find_user
      # This method is implemented in User model
      @user = User.find_from_oauth(request.env["omniauth.auth"], current_user)

    end
  end
end
