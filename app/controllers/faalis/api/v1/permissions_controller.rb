require_dependency "faalis/application_controller"

module Faalis
  class API::V1::PermissionsController < ::APIController

    respond_to :json

    class DummyPerm
      attr_accessor :model, :permission_type
    end

    # @api GET permissions
    # @return All permissions
    def index
      @permissions = {}

      Faalis::Permission.each do |perm|
        if @permissions.include? perm.model
          @permissions[perm.model] << perm.action
        else
          @permissions[perm.model] = [perm.action]
        end
      end

      respond_with(@permissions)
    end

    # @api GET permissions/user
    # @return current user permissions
    def user_permissions

      @permissions = {}
      current_user.permissions.each do |perm|
        if @permissions.include? perm.model
          @permissions[perm.model] << perm.action
        else
          @permissions[perm.model] = [perm.action]
        end
      end

      respond_with(@permissions)
      return

      @permissions = {}
      perms = []

      # Generate a suitable Hash for permissions
      perms.each do |perm|
        if @permissions.include? perm.model
          @permissions[perm.model] << perm.permission_type.to_s
          @permissions[perm.model] = @permissions[perm.model].uniq
        else
          @permissions[perm.model] = [perm.permission_type.to_s]
        end
      end
      respond_with(@permissions)
    end

  end
end
