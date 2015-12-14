module Faalis::Dashboard
  class UsersController < ::Dashboard::ApplicationController

    def index
      authorize Faalis::User
      @users = Faalis::User.all
    end

    def new
      authorize Faalis::User
      @user   = Faalis::User.new
      @groups = Faalis::Group.all
    end

    def show
      @user = Faalis::User.find(params[:id])
      authorize @user
    end

    def edit
      @user   = Faalis::User.find(params[:id])
      @groups = Faalis::Group.all
      authorize @user
    end

    def create
      authorize Faalis::User
      group_ids = user_params[:groups]

      @user = Faalis::User.new(user_params)
      @user.groups = Faalis::Group.where(id: group_ids)

      respond_to do |f|
        if @user.save
          f.js
          f.html
        else
          f.js { render :errors }
          f.html
        end
      end
    end

    def update
      parameters = user_params
      groups     = parameters.delete(:groups)


      @user = Faalis::User.find(params[:id])
      authorize @user

      unless groups.nil?
        group_ids    = groups.map(&:to_i)
        @user.groups = Faalis::Group.where(id: group_ids)
        @user.save
      end

      respond_to do |f|
        if @user.update_without_password(parameters)
          f.js
          f.html
        else
          f.js { render :errors }
          f.html
        end
      end
    end

    def edit_password
      @user = Faalis::User.find(params[:id])
      authorize @user, :update?
    end

    def update_password
      @user = Faalis::User.find(params[:id])
      authorize @user, :update?

      respond_to do |f|
        if @user.update(password_params)
          f.js
          f.html
        else
          f.js { render :errors }
          f.html
        end
      end
    end

    def destroy
      @user = Faalis::User.find(params[:id])
      authorize @user

      @user.destroy
    end

    private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def user_params
      params[:user][:groups] ||= []
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :groups => [])
    end
  end
end
