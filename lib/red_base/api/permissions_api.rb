module RedBase
  module API
    class PermissionsAPI < Grape::API

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

          permissions
        end
      end

    end
  end
end
