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
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Copy all the necessary files to use Faalis"
      class_option :orm

      def install_mailboxer
        invoke "mailboxer:install"
      end

      def install_model_discovery
        rake "model_discovery_engine:install:migrations"
      end

      def copy_init_files
        template "devise.rb", "config/initializers/devise.rb"
        template "faalis.rb", "config/initializers/faalis.rb"
        template "fast_gettext.rb", "config/initializers/fast_gettext.rb"
        template "formtastic.rb", "config/initializers/formstatic.rb"
        template "seeds.rb", "db/seeds.rb"
        template "api_controller.rb", "app/controllers/api_controller.rb"
      end

      def copy_js_manifest
        template "application.js", "#{angularjs_app_path}application.js"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end

      private

      def angularjs_app_path
        path = Faalis::Engine.dashboard_js_manifest.split("/")[0..-2].join("/")
        "app/assets/javascripts/#{path}/"
      end

    end
  end
end
