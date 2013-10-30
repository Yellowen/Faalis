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
        RedBase::User.all
      end

    end
  end
end
