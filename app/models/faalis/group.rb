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
  # **Group** model for **Faalis** platform
  class Group < Faalis::ORM.proper_base_class
    # Define **Group** fields if current ORM was **Mongoid**
    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps
      include Faalis::Permissions

      field :name, type: String
      embedded_in :user
      embeds_many :permissions
    end

    # Group Definition for **ActiveRecord**
    if Faalis::ORM.active_record?
      has_and_belongs_to_many :users
      has_and_belongs_to_many :permissions
    end

    # Validations
    validates :name, presence: true

  end
end
