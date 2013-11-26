require_dependency "red_base/application_controller"

module RedBase
  class API::V1::PermissionsController < ApplicationController

    # GET /api/v1/groups
    def index
      @permissions = []

      RedBase::Engine.models_with_permission.each do |model|
        model = Object.const_get(model)
        @permissions.concat(model::Permissions.permission_strings(model))
      end

    end
  end
end
