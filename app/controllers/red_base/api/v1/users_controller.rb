require_dependency "red_base/application_controller"

module RedBase
  class API::V1::UsersController < ApplicationController
    def index
      @users = User.all
      respond_to do |format|
        format.json { render :json => @users}
      end
    end

    def show

    end

    def distroy
    end

    def edit
    end

    def create
      group = group.find(params[:group])
      @user = User.create!({
                             first_name: params[:first_name],
                             last_name: params[:last_name],
                             email: params[:email],
                             password: params[:passwprd],
                             group: params[:group],
                           })
    end
  end
end
