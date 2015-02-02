# == Schema Information
#
# Table name: faalis_permissions
#
#  id              :integer          not null, primary key
#  model           :string
#  permission_type :string
#  created_at      :datetime
#  updated_at      :datetime
#

module Faalis
  class Permission < Faalis::ORM.proper_base_class

    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps

      field :model, type: String
      field :permission_type, type: String

    end

    has_and_belongs_to_many :groups, class_name: 'Faalis::Group'
    alias_attribute :action, :permission_type

    #alias_method :action, :permission_type

    def to_s
      _("can %s %s") % [_(self.permission_type.to_s), self.model.underscore.humanize]
    end

    def id_repr
      "#{self.permission_type.to_s}|#{self.model}"
    end

  end
end
