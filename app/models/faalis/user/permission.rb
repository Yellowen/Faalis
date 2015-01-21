module Faalis
  # This concern contains all the permission related methods
  # to use within `Faalis::User`
  module User::Permission

    extend ActiveSupport::Concern


    # Return an array of user roles.
    def roles
      self.groups.to_a.map(&:role)
    end

    def role? role
      roles.include? role.to_s
    end

    # Return all the user permissions
    def permissions
      perms = []

      groups.each do |group|
        group.permissions.each do |perm|
          # It's obvious isn't it ?
          yield perm if block_given?
          perms << perm
        end
      end

      perms
    end
  end
end
