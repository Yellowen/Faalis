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
  class Plugins

    @@plugins = {}

    def self.register(plugin_name, plugin_class)
      # TODO: Re-think this approach. Do we need to keep plugin classes too?
      if not @@plugins.include? plugin_name
        @@plugins[plugin_name] = plugin_class
      end
    end

    # Return name of all registered plugins
    def self.names
      @@plugins.keys
    end

    # Return the actual plugins hash
    def self.plugins
      @@plugins
    end

  end
end
