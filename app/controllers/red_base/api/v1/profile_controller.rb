require_dependency "red_base/application_controller"

module RedBase
  class API::V1::ProfilesController < APIController
    def show
      if user_signed_in
        @user = current_user
      else
        respond_to do |format|
          format.json {"You should signin"}
        end
      end

    end

    def update
    end

  end
end
