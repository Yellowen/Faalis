module RedBase
  module API
    class GroupsAPI < Grape::API

      resource :groups do

        desc "Return all the groups"
        get do
          authenticated_user
          # TODO: Check for admin user only
          RedBase::Group.all
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
                          permisssions: permissions,
                        })
        end
      end
    end
  end
end
