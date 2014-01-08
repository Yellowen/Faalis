# -----------------------------------------------------------------------------
#    Red Base - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------

module Faalis
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
