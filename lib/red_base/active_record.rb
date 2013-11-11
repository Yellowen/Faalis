# -----------------------------------------------------------------------------
#    Red Base - Basic website skel engine
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

module ActiveRecord
  class Base

    class Permissions
      @@permissions = {
        :read => nil,
        :update => nil,
        :create => nil,
        :destory => nil,
      }

      @@only_owner = false

      # return an array of strings representation of permissions
      def self.permission_strings(model_name)
        strings = []
        @@permissions.each do |key, value|
          strings << _("can %s %s") % [_(key.to_s), model_name]
        end
        strings
      end

      # Define permissions using this method
      def self.permissions(*args)

        args.each do |permission|
          if permission.class == Symbol
            if not @@permissions.include? permission
              @@permission[permission] = nil

            elsif permission.class == Hash

              permission.each do |key, value|
                @@permissions[key.to_sym] = value
              end

            end
          end


        end
      end

      # This force user to have access to resources which is his.
      def self.only_his_objects
        @@only_owner = true
      end

      def self.only_his_objects?
        @@only_owner
      end

    end
  end
end
