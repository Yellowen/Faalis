class Faalis::Dashboard::ProfileController < ::ApplicationController
  layout false
  def show
    @user = current_user
    respond_with(@user)
  end

  def update
    @user = ::Faalis::User.find(current_user.id)
    authorize @user
    respond_to do |f|
      if @user.update_without_password(resource_params)
        f.js { }
        f.html { }
      else
        @errors = @user.errors
        f.js {render :errors}
        f.html
      end
    end

  end


  # GET /sites/new
  def edit_password
    @user = ::Faalis::User.find(current_user.id)
    authorize @user
  end

  def update_password
    @user = ::Faalis::User.find(current_user.id)
    authorize @user
    respond_to do |f|
      if @user.update_with_password(resource_params)
        f.js { redirect_to new_user_session_path }
        f.html { redirect_to new_user_session_path }
      else
        @errors = @user.errors
        f.js {render :errors}
        f.html
      end
    end
  end

  def resource_params
    params.require(:user).permit(:password, :current_password, :password_confirmation, :first_name, :last_name, :email)
  end
end
