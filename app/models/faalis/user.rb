# == Schema Information
#
# Table name: faalis_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0")
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  first_name             :string
#  last_name              :string
#  group_id               :integer          default("2")
#  failed_attempts        :integer          default("0")
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

module Faalis
  # **User** model for **Faalis** platform
  class User < Faalis::ORM.proper_base_class

    # Define **User** fields if current ORM was Mongoid -----------------------
    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps
      include Faalis::Concerns::User::MongoidFields
    end

    # Callbacks ---------------------------------------------------------------
    before_create :join_guests

    # AuthDefinitions contains all the **Devise** related configurations.
    include Faalis::Concerns::User::AuthDefinitions
    # Permission related methods for user
    include Faalis::Concerns::User::Permission
    # Roles related methods for user
    include Faalis::Concerns::User::UserRoles

    # Gravatar
    include Faalis::Concerns::User::Gravatar

    # Make this model authorizable
    include Faalis::Concerns::Authorizable

    # Define **User** fields if current ORM was ActiveRecord-------------------
    if Faalis::ORM.active_record?
      # acts as messageable for mailboxer
      #acts_as_messageable
    end

    has_and_belongs_to_many :groups, class_name: 'Faalis::Group', uniq: true

    # Validations
    validates :password, presence: true, length: { minimum: 5, maximum: 120 }, on: :create
    validates :password, length: { minimum: 5, maximum: 120 }, on: :update, allow_blank: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

    devise *@@devise_options

    # It's totally obviuse. Join the guest group if no group provided
    def join_guests
      #::Faalis::Group.find_by(role: 'guest')
      if groups.empty?
        guest_group = ::Faalis::Group.find_or_create_by(name: 'Guest',
                                                        role: 'guest')
        self.groups << guest_group
      end
    end

    def self.policy_class
      Faalis::UserPolicy
    end

  end
end
