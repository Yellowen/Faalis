module Faalis
  class Routes
    def self.define_api_routes(routes=Rails.application.routes)

      routes.draw do
        scope 'module'.to_sym => 'faalis' do
          namespace :api, :defaults => {:format => :json} do
            namespace :v1 do
              get 'permissions', :to => 'permissions#index'
              get 'permissions/user', :to => 'permissions#user_permissions'
              resources :groups, :except => [:new]
              resources :users, :except => [:new]
              resource :profile, :except => [:new, :destroy]

              get 'logs' => 'logs#index'
            end
          end
        end
      end
    end
  end
end
