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
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Copy all the necessary files to use Red Base"
      class_option :orm

      def copy_init_files
        template "devise.rb", "config/initializers/devise.rb"
        template "red_base.rb", "config/initializers/red_base.rb"
        template "fast_gettext.rb", "config/initializers/fast_gettext.rb"
        template "formtastic.rb", "config/initializers/formstatic.rb"
        template "seeds.rb", "db/seeds.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end

    end
  end
end
