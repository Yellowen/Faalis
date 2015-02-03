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
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/', __FILE__)

      desc "Copy all templates and assets to main application"

      def copy_views_file
        directory "views/faalis", "app/views/faalis"
        directory "views/layouts/faalis", "app/views/layouts/faalis"
        directory "views/angular", "app/views/layouts/faalis"

      end

      def copy_assets_file
        directory "assets/javascripts/faalis", "app/assets/javascripts/faalis"
        directory "assets/stylesheets/faalis", "app/assets/stylesheets/faalis"
        directory "assets/images/faalis", "app/assets/images/faalis"

      end

    end
  end
end
