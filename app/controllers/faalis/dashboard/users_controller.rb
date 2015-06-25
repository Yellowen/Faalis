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
    @user   = Faalis::User.find(params[:id])
    @groups = Faalis::Group.all
    authorize @user
  end

  def create
    authorize Faalis::User
    group_ids = user_params[:groups]

    @user = Faalis::User.build(user_params)
    @user.groups Faalis::Group.where()

  end

  def update
    @user = Faalis::User.find(params)
    authorize @user


  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 groups: [])
  end
end
