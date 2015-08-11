module Faalis
  module API
    class UsersAPI < Grape::API


      resource :users do

        desc "Return all the users"
        get do
          authenticated_user
          # TODO: Check for admin user only
          Faalis::User.all
        end

      end


    end
  end
end
