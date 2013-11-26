require_dependency "red_base/application_controller"

module RedBase
  class API::V1::GroupsController < ApplicationController

    # GET /api/v1/groups
    def index
      @groups = Group.includes(:permissions).all
    end

    def create
      permissions = [];

      params[:permissions].each do |perm_string|
        perm, model = perm_string.split "|"
        permission = Permission.find_or_create_by_model_and_permission_type(model, perm)
        permissions << permission
      end

      @group = Group.create!({
                               name: params[:name],
                               permissions: permissions,
                             })

    end

    def show
    end

    def edit
    end

    def new
    end

    def destroy
    end
  end

end
