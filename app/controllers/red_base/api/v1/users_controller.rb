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
      @user = User.find(params[:id])
      authorize! :read, @user
    end

    def distroy
    end

    def update
      group = Group.find(params[:group])
      @user = User.find(params[:id])
      authorize! :update, @user
      @user.update({
                     first_name: params[:first_name],
                     last_name: params[:last_name],
                     email: params[:email],
                     password: params[:password],
                     group: group,
                   })
    end

    def create
      puts "##################################"
      group = Group.find(params[:group])
      if group
        @user = User.create!({
                               first_name: params[:first_name],
                               last_name: params[:last_name],
                               email: params[:email],
                               password: params[:password],
                               group: group,
                             })
      end
    end
  end
end
