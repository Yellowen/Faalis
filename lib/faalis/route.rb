
module Faalis
  class Routes
    # This class method will add `Faalis` routes to host application
    # Router
    def self.define_api_routes(routes = Rails.application.routes)

      routes.draw do
        scope 'module'.to_sym => 'faalis' do
          # TODO: Add a dynamic solution for formats
          namespace :api, defaults: {format: :json} do
            namespace :v1 do
              get 'permissions', to: 'permissions#index'
              get 'permissions/user', to: 'permissions#user_permissions'
              resources :groups, except: [:new]
              resources :users, except: [:new]
              resource :profile, except: [:new, :destroy]

              get 'logs' => 'logs#index'
            end
          end
        end
      end

    end
  end
end
