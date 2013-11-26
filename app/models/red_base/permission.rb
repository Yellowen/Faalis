module RedBase
  class Permission < ActiveRecord::Base

    has_and_belongs_to_many :groups

    def to_s
      _("can %s %s") % [_(self.permission_type.to_s), RedBase::Permission.model_name.human]
    end
  end
end
