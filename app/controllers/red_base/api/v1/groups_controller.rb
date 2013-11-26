require_dependency "red_base/application_controller"

module RedBase
  class API::V1::GroupsController < ApplicationController

    # GET /api/v1/groups
    def index
      @groups = Group.includes(:permissions).all
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
