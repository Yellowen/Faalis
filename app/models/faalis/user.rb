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

    include Faalis::User::AuthDefinitions

    # Define **User** fields if current ORM was mongoid
    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps
      include Faalis::User::Mongoid
    end

    # TODO: Check this gem for mongoid support
    #acts as messageable for mailboxer
    acts_as_messageable

    validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true
    validates :email, presence: true, length: {minimum: 6}

    belongs_to :group

  end
end
