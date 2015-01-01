
module Faalis
  class Routes

    def self.localized_scop(router: Rails.application.routes)
      langs = ::I18n.available_locales.join('|')
      router.scope '(:locale)', locale: Regexp.new(langs)
    end

    # This class method will add `Faalis` routes to host application
    # Router
    def self.define_api_routes(routes: Rails.application.routes,
                               version: :v1,
                               &block)

      routes.draw do
        # TODO: Add a dynamic solution for formats
        namespace :api, defaults: {format: :json} do
          namespace version do

            # Call user given block to define user routes
            # inside this namespace
            block.call if block_given?
          end
        end

        scope 'module'.to_sym => 'faalis' do
          # TODO: Add a dynamic solution for formats
          namespace :api, defaults: {format: :json} do
            namespace version do
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
