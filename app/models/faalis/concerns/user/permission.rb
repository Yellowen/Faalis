module Faalis
  # This concern contains all the permission related methods
  # to use within `Faalis::User`
  module Concerns::User::Permission
    extend ActiveSupport::Concern

    def have_permission? action, obj
      perm = self.groups.includes(:permissions)
        .where(faalis_permissions: { model: obj, permission_type: action })
        .count
      perm == 1
    end

    # Return all the user permissions
    def permissions

    end
  end
end
