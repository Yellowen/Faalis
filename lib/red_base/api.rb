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

module RedBase
  module API

    #autoload UsersAPI, "red_base/api/users_api"
    #autoload GroupsAPI, "red_base/api/groups_api"
    #autoload PermissionsAPI, "red_base/api/permissions_api"

    class Base < Grape::API

      def self.setup_api

        # TODO: Allow user to configure this section
        version 'v1', :vendor => "Yellowen"
        format :json
        default_format :json

        # TODO: Give this class a logger

        helpers do

          def warden
            env['warden']
          end

          def current_user
            warden.user
          end

          def authenticated_user
            if warden.authenticated?
              return true
            else
              error!('401 Unauthorized', 401)
            end
          end

        end

      end
    end
  end
end
