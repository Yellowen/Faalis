class Faalis::Dashboard::UsersController < ::ApplicationController
  layout false

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
    @user = Faalis::User.find(params[:id])
    authorize @user
  end

  def create
    authorize Faalis::User
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
