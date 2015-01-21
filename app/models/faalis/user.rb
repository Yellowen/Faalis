module Faalis
  # **User** model for **Faalis** platform
  class User < Faalis::ORM.proper_base_class

    # Define **User** fields if current ORM was Mongoid -----------------------
    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps
      include Faalis::User::MongoidFields
    end

    # Callbacks ---------------------------------------------------------------
    before_create :join_guests

    # AuthDefinitions contains all the **Devise** related configurations.
    include Faalis::User::AuthDefinitions
    # Permission related methods for user
    include Faalis::User::Permission

    # Make this model authorizable
    include Faalis::Concerns::Authorizable

    # Define **User** fields if current ORM was ActiveRecord-------------------
    if Faalis::ORM.active_record?
      # acts as messageable for mailboxer
      #acts_as_messageable
    end

    has_and_belongs_to_many :groups, class_name: 'Faalis::Group'

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
  end
end
