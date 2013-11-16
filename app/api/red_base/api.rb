module RedBase
  class API < Grape::API
    version 'v1', :vendor => "Yellowen"
    format :json
    default_format :json

    # TODO: Give this class a logger

     helpers do

      def warden
        env['warden']
      end

      def current_user
        warden.user
      end

      def authenticated_user
        if warden.authenticated?
          return true
        else
          error!('401 Unauthorized', 401)
        end
      end

    end

    resource :users do

      desc "Return all the users"
      get do
        authenticated_user
        # TODO: Check for admin user only
        RedBase::User.all
      end

    end

    resource :permissions do

      desc "Return all permissions available"
      get do
        authenticated_user
        # TODO: Check for admin user only
        permissions = []

        RedBase::Engine.models_with_permission.each do |model|
          model = Object.const_get(model)
          permissions.concat(model::Permissions.permission_strings(model))
        end

        i = 1
        permissions.each do |perm|
          perm["id"] = i
          i += 1
        end
        {:permissions => permissions}
      end
    end

  end
end
