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
              get 'workflows' => 'workflows#index'

              resources :conversations, only: [:index, :show, :create, :destroy] do
                collection do
                  get ':box/box' => 'conversations#index'
                  post 'trash' => 'conversations#trash'
                  post 'untrash' => 'conversations#untrash'
                end
                member do
                  post :reply
                end
              end
            end
          end
        end
      end
    end
  end
end
