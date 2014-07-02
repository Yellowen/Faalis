# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------

module Faalis
  # **User** model for **Faalis** platform
  class User < Faalis::ORM.proper_base_class

    # AuthDefinitions contains all the **Devise** related configurations.
    include Faalis::User::AuthDefinitions
    # Permission related methods for user
    include Faalis::User::Permission

    # Make this model authorizable
    include Faalis::Concerns::Authorizable

    # Define **User** fields if current ORM was Mongoid -----------------------
    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps
      include Faalis::User::MongoidFields
      # FIXME: Port mailboxer to work with mongoid
    end

    # Define **User** fields if current ORM was ActiveRecord-------------------
    if Faalis::ORM.active_record?
      # acts as messageable for mailboxer
      #acts_as_messageable
    end

    has_and_belongs_to_many :groups, class_name: 'Faalis::Group'

    # Validations
    validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true
    validates :email, presence: true, length: {minimum: 6}

    devise *@@devise_options

  end
end
