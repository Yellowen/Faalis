require_dependency "faalis/application_controller"

module Faalis
  class API::V1::UsersController < ::APIController

    def index
      @users = User.joins(:groups).all
      #authorize! :read, @users
      respond_with(@users)
    end

    def show
      @user = User.find(params[:id])
      authorize! :read, @user
      respond_with(@user)
    end

    def destroy
      ids = params[:id].split(",")
      @users = User.where(:id => ids)
      authorize! :destory, @users
      @users.destroy_all
    end

    def update
      @user = User.find(params[:id])
      authorize! :update, @user
      user_fields = {
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email],
      }

      if params.include? :password and params[:password]
        user_fields[:password] =  params[:password]
      end

      if params.include? :groups and params[:groups]
        user_fields[:groups] =  Group.find(params[:groups]) || nil
      end

      if @user.update(user_fields)
        respond_with(@user)
      else
        respond_to do |format|
          format.json { render :json => {:fields => @user.errors}, :status => :unprocessable_entity }
        end
      end
    end

    def create
      authorize! :create, Faalis::User

      @user = User.new({
                         first_name: params[:first_name],
                         last_name: params[:last_name],
                         email: params[:email],
                         password: params[:password],
                       })

      if params.include? :groups
        group = Group.find(params[:groups]) || nil
        @user.groups = group
      end

      if @user.save
        respond_with(@user)
      else
        respond_to do |format|
          format.json { render :json => {:fields => @user.errors}, :status => :unprocessable_entity }
        end
      end
    end
  end
end
