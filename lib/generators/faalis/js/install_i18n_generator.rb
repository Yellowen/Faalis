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
    module Js
      # Generator responsible for `install_i18n` generator
      class InstallI18nGenerator < Rails::Generators::Base
        source_root File.expand_path('../../templates/', __FILE__)

        desc 'Copy all the necessary files to use Faalis client side i18n'

        def copy_init_files
          template 'i18n/Gruntfile.js.erb', 'lib/tasks/grunt/Gruntfile.js'
          copy_file 'i18n/fa.js', 'app/assets/javascripts/locales/fa.js'
        end

        def show_readme
          readme 'i18n/README' if behavior == :invoke
        end

        private

        def angularjs_app_path
          path = Faalis::Engine.dashboard_js_manifest.split('/')[0..-2].join('/')
          "app/assets/javascripts/#{path}/"
        end
      end
    end
  end
end
