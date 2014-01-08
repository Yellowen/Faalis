require_dependency "faalis/application_controller"

module Faalis
  class API::V1::PermissionsController < ApplicationController

    # GET /api/v1/groups
    def index
      @permissions = []

      Faalis::Engine.models_with_permission.each do |model|
        model = Object.const_get(model)
        @permissions.concat(model::Permissions.permission_strings(model))
      end

    end
  end
end
