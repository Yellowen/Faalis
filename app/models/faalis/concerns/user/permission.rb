module Faalis
  # This concern contains all the permission related methods
  # to use within `Faalis::User`
  module Concerns::User::Permission

    extend ActiveSupport::Concern

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
