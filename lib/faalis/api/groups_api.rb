module Faalis
  module API
    class GroupsAPI < Grape::API

      resource :groups do

        desc "Return all the groups"
        get do
          authenticated_user
          # TODO: Check for admin user only
          Faalis::Group.includes(:permissions)
        end

        delete do
          authenticated_user

          #if can? :delete, Group
          #end
          Group.delete(params[:id].split(","))
        end

        post do
          authenticated_user

          permissions = [];

          params[:permissions].each do |perm_string|
            perm, model = perm_string.split "|"
            permission = Permission.find_or_create_by_model_and_permission_type(model, perm)
            permissions << permission
          end

          Group.create!({
                          name: params[:name],
                          permissions: permissions,
                        })
        end
      end
    end
  end
end
