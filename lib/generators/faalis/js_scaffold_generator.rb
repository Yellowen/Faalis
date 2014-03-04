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
    # `js_scaffold` main class
    class JsScaffoldGenerator < Faalis::Generators::DashboardScaffold
      # We keep this class to keep backward compatiblity
      puts "[DEPRECATED]: This generator will be removed soon, Use faalis:js:list_view instead."
      # TODO: Remove this ater a while


      # templates path
      source_root File.expand_path('../templates', __FILE__)

      # Field name to use as title of each object
      class_option :title_field, :type => :string, :default => "name", :desc => "Field name to use as title of each object"

      # Don't copy the new.html template
      class_option :no_new_template, :type => :boolean, :default => false, :desc => "Don't copy the new.html template"

      desc "Create a new resource for client side application"
      def create_module
        unless options[:only_controller]
          unless options[:only_specs]
            template "angularjs/module.js.erb", "#{angularjs_app_path}modules/#{resource_path}.js"
          end
        end
      end

      def create_template
        unless options[:only_controller]
          unless options[:only_specs]
            template "angularjs/index.html.erb", "app/views/angularjs_templates/#{resource.underscore}/index.html"
            unless options[:no_new_template]
              template "angularjs/new.html.erb", "app/views/angularjs_templates/#{resource.underscore}/new.html"
            end
            template "angularjs/details.html.erb", "app/views/angularjs_templates/#{resource.underscore}/details.html"
          end
        end

        unless options[:only_specs]
          template "views/index.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/index.json.jbuilder"
          template "views/show.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/show.json.jbuilder"
          template "views/create.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/create.json.jbuilder"
          template "views/destroy.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/destroy.json.jbuilder"
          template "views/update.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/update.json.jbuilder"
        end
      end

      def create_api
        unless options[:only_specs]
          template "api/controller.rb.erb", "app/controllers/api/v1/#{resource.pluralize.underscore}_controller.rb"
        end
      end

      def create_specs
        unless options[:without_specs]
          template "features/api.feature", "features/#{resource.underscore}.api.feature"
          template "features/api.step.rb", "features/step_definitions/#{resource.underscore}.rb"
        end
      end

      def show_readme
        readme "js_scaffold.README" if behavior == :invoke
      end

      # PRIVATES --------------------------------------------
      private

      def is_in_engine?
        false
      end

      def random_json_data
        data = {}
        fields.each do |field, type|
          case type
          when "belongs_to"
            data["#{field}_id"] = 1
          when "integer"
            data[field] = 1+ rand(1000)
          else
            data[field] = random_string
          end
        end
        data.to_json.to_s
      end

      def random_string
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        (0...50).map{ o[rand(o.length)] }.join
      end

    end
  end
end
