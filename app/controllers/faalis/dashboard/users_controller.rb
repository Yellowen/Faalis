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
    group_ids = user_params[:groups]

    @user = Faalis::User.find(params)
    authorize @user

    @user.groups = Faalis::Group.where(id:group_ids)
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
