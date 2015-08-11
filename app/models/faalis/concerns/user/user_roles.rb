module Faalis
  # This concern contains all the role related methods
  # to use within `Faalis::User`
  module Concerns::User::UserRoles

    # Return an array of user roles.
    def roles
      self.groups.to_a.map(&:role)
    end

    def role? role
      roles.include? role.to_s
    end

    # A shortcut for `role? :admin`
    def admin?
      role? :admin
    end
  end
end
