require_dependency "faalis/api/users_api"
require_dependency "faalis/api/groups_api"
require_dependency "faalis/api/permissions_api"

module Faalis
  module API
    class Root < Grape::API

      mount API::UsersAPI
      mount API::GroupsAPI
      mount API::PermissionsAPI

    end
  end
end
