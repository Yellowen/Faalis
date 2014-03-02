require_dependency "faalis/application_controller"

module Faalis
  class API::V1::PermissionsController < ::APIController

    class DummyPerm
      attr_accessor :model, :permission_type
    end

    # @api GET permissions
    # @return All permissions
    def index
      @permissions = []

      ::ApplicationModels.all.each do |m|

        model = m.model.constantize
        if model.respond_to? :permission_strings
          @permissions.concat(model.permission_strings(model))
        end
      end

      Faalis::Engine.models_with_permission.each do |m|
        model = m.constantize
        if model.respond_to? :permission_strings
          @permissions.concat(model.permission_strings(model))
        end
      end

      respond_with(@permissions.uniq)
    end

    # @api GET permissions/user
    # @return current user permissions
    def user_permissions
      @permissions = {}
      perms = []
      if current_user.group_id == 1
        # Generate all possible permissions for admin group
        ::ApplicationModels.all.each do |model|
          model.model.constantize.possible_permissions.each do |p|
            perm = DummyPerm.new
            perm.model = model.model
            perm.permission_type = p
            perms << perm
          end
        end
        Faalis::Engine.models_with_permission.each do |m|
          m.constantize.possible_permissions.each do |p|
            perm = DummyPerm.new
            perm.model = m
            perm.permission_type = p
            perms << perm
          end
        end
        perms.uniq!
      else
        perms = current_user.group.permissions
      end

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
