class Faalis::Dashboard::PermissionsController < ApplicationController
  layout false

  def new
    @permissions = {}

    Faalis::Permission.all.each do |perm|
      if @permissions.include? perm.model_name
        @permissions[perm.model_name] << perm.permission_type
      else
        @permissions[perm.model_name] = [perm.permission_type]
      end
    end
  end
end
