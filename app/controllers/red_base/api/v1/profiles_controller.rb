require_dependency "red_base/application_controller"

module RedBase
  class RegistrationsController < ::Devise::RegistrationsController
    #layout :defined_layout
    def edit
      super
      render :template => "registrations/edit2"
    end

  end

=begin
    def show
        @user = current_user
        respond_with(@user)
    end

    def update
      if user_signed_in?
        @user = current_user
        user_fields = {
          :first_name => params[:first_name],
          :last_name => params[:last_name],
          :email => params[:email],
        }
        if @user.update_without_password(user_fields)
          respond_with(@user)
        else          respond_to do |format|
            format.json { render :json => {:fields => @user.errors}, :status => :unprocessable_entity }
          end
        end
      end
    end
end
=end
end
