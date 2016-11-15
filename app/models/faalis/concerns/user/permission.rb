module Faalis
  # This concern contains all the permission related methods
  # to use within `Faalis::User`
  module Concerns::User::Permission
    extend ActiveSupport::Concern

    def member_of?(group)
      @group_ids ||= self.groups.all.map(&:id)
      @group_ids.include? group.id
    end

    # TODO: merge this method and `member_of?`
    def member_of_group?(group_name)
      !self.groups.find_by(name: group_name).nil?
    end

    def has_permission? action, obj
      perm = self.groups.includes(:permissions)
        .where(faalis_permissions: { model: obj, permission_type: action })
        .count
      perm == 1
    end

    def can_not? action, obj
      !has_permission? action, obj
    end

    alias_method :can?, :has_permission?

    def has_ownership?(record)
      has_permission? :ownership, record.name
    end

    def owned?(record)
      if has_permission? :ownership, record.name
        if record.respond_to? :user
          return true if record.user == self
          return false
        end

        if record.respond_to? :__owned_by
          return true if record.__owned_by == self
        end
      end
      false
    end

    def permissions
      groups.includes(:permissions).map(&:permissions).flatten.uniq
    end
  end
end
