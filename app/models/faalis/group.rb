# == Schema Information
#
# Table name: faalis_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  role       :string
#  created_at :datetime
#  updated_at :datetime
#

module Faalis
  # **Group** model for **Faalis** platform
  class Group < Faalis::ORM.proper_base_class

    # Make this model authorizable
    include Faalis::Concerns::Authorizable

    # Define **Group** fields if current ORM was **Mongoid**
    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps

      field :name, type: String
      field :role, type: String
    end

    has_and_belongs_to_many :users, class_name: 'Faalis::User'
    has_and_belongs_to_many :permissions, class_name: 'Faalis::Permission'

    # Validations
    validates :name, presence: true
    validates :role, presence: true, uniqueness: true

    def self.policy_class
      GroupPolicy
    end

    def include_permission?(perm)
      if perm.is_a? Fixnum
        permission_ids.include? perm
      else
        permission_ids.include? perm.id
      end
    end

    private

    def permission_ids
      @permission_ids ||= permissions.map(&:id)
    end
  end
end
