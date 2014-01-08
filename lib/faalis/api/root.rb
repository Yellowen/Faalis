require_dependency "red_base/api/users_api"
require_dependency "red_base/api/groups_api"
require_dependency "red_base/api/permissions_api"

module RedBase
  module API
    class Root < Grape::API

      mount API::UsersAPI
      mount API::GroupsAPI
      mount API::PermissionsAPI

    end
  end
end
