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
    # Generator responsible for `install` generator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc 'Copy all the necessary files to use Faalis'
      class_option :orm

      def copy_migrations
        rake('faalis:install:migrations') unless options[:mongoid]
      end

      def install_model_discovery
        rake 'model_discovery_engine:install:migrations'
      end

      def copy_init_files
        template 'devise.rb', 'config/initializers/devise.rb'
        template 'faalis.rb', 'config/initializers/faalis.rb'
        template 'seeds.rb', 'db/seeds.rb'
        template 'api_controller.rb', 'app/controllers/api_controller.rb'
        template 'dashboard_controller.rb', 'app/controllers/dashboard/application_controller.rb'
        template 'policy/application_policy.rb', 'app/policies/application_policy.rb'
      end

      def copy_js_manifest
        empty_directory 'app/assets/javascripts/dashboard'
        directory 'javascripts', 'app/assets/javascripts/dashboard'
      end

      #def grunt_file
      #  template 'i18n/Gruntfile.js.erb', 'lib/tasks/grunt/Gruntfile.js'
      #end

      def copy_scss_manifest
        directory 'stylesheets', 'app/assets/stylesheets'
      end

      def install_routes
         route "end\n"
         route '  # Your dashboard routes goes here.'
         route 'in_dashboard do'
         route "end\n"
         route '  # Your API routes goes here.'
         route 'api_routes do'
         route "mount Faalis::Engine => '/'\n"
      end

      def assets_manifests_initializer
        initializer 'faalis_assets.rb' do
          'Rails.application.config.assets.precompile += %w( faalis/simple.js )'
        end
      end

      def patch_application_controller
        inject_into_class "app/controllers/application_controller.rb", ApplicationController, "  extend Faalis::I18n::Locale\n"
      end

      def add_gems
        # Inject necessary gem files
        if Rails.version.starts_with? '5'
          add_source 'http://rails-assets.org' do
            gem 'rails-assets-bootstrap-rtl'
            gem 'rails-assets-jquery-knob'
            gem 'rails-assets-bootstrap-daterangepicker'
            gem 'rails-assets-jquery-sparkline'
            gem 'rails-assets-jquery-icheck'
          end

        else
          add_source 'http://rails-assets.org'
          gem 'rails-assets-bootstrap-rtl'
          gem 'rails-assets-jquery-knob'
          gem 'rails-assets-bootstrap-daterangepicker'
          gem 'rails-assets-jquery-sparkline'
          gem 'rails-assets-jquery-icheck'
        end

        #gem 'turbolinks', github: 'rails/turbolinks'
        gem 'jquery-turbolinks'


        inside Rails.root do
          run 'rm Gemfile.lock'
          run 'bundle install'
        end
      end


      def configure_kaminari
        generate 'kaminari:config'
      end

      def install_formtastic
        generate 'formtastic:install'

        append_to_file 'config/initializers/formtastic.rb' do
          'Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder'
        end
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end

      private

      def angularjs_app_path
        path = Faalis::Engine.dashboard_js_manifest.split('/')[0..-2].join('/')
        "app/assets/javascripts/#{path}/"
      end
    end
  end
end
