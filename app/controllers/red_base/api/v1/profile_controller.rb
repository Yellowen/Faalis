require_dependency "red_base/application_controller"

module RedBase
  class API::V1::ProfilesController < APIController
    def show
      if user_signed_in?
        @user = current_user
      else
        respond_to do |format|
          format.json {"You should signin"}
        end
      end

    end

    def update
      if user_signed_in?
        @user = current_user
        user_fields = {
          :first_name => params[:first_name],
          :last_name => params[:last_name],
          :email => params[:email],
        }
        if params.include? :password
          user_fields[:password] = params[:password]
          user_fields[:password_confirmation] = params[:password_confirmation]
          if @user.update(user_fields)
            respond_with(@user)
          else
            respond_to do |format|
              format.json { render :json => {:fields => @user.errors}, :status => :unprocessable_entity }
            end
          else
              if @user.update_without_password(user_fields)
                respond_with(@user)
              else
                respond_to do |format|
                  format.json { render :json => {:fields => @user.errors}, :status => :unprocessable_entity }
                end
              end
            end
          end

        end
      end
