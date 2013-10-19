module RedBase
  module Omniauth

    module Callbacks


      def default_service_callback

        create_or_find_user

        if @user.persisted?
          # This will throw if @user is not activated
          sign_in_and_redirect @user, :event => :authentication
          set_flash_message(:notice, :success, :kind => __callee__.to_s) if is_navigational_format?
        else
          session["devise.omni_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end


      if Devise.omniauth_configs.any?
        Devise.omniauth_configs.keys.each do |provider|
          unless method_defined? provider
            send(:define_method, provider.to_sym) {default_service_callback}
          end
        end
      end

      private

      def create_or_find_user
        # This method is implemented in User model
        @user = User.find_from_oauth(request.env["omniauth.auth"], current_user)
      end

    end
  end
end
