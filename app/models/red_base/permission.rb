module RedBase
  class Permission < ActiveRecord::Base

    has_and_belongs_to_many :groups

    def string_repr
      _("can %s %s") % [_(self.permission_type.to_s), self.model.underscore.humanize]
    end

    def id_repr
      "#{self.permission_type.to_s}|#{self.model}"
    end

  end
end
