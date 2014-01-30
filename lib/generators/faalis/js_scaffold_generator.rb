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

module Faalis
  module Generators
    class JsScaffoldGenerator < Rails::Generators::Base

      include ActionView::Helpers::TextHelper

      source_root File.expand_path('../templates', __FILE__)

      argument :resource_name, :type => :string, :required => true
      argument :resource_fields, type: :array, default: [], banner: "fields[:types]"
      class_option :without_specs, :type => :boolean, :default => false, :desc => "Do not install specs"
      class_option :only_specs, :type => :boolean, :default => false, :desc => "Generate only spec files"
      class_option :only_controller, :type => :boolean, :default => false, :desc => "Generate only controller"
      class_option :bulk_fields, :type => :string, :default => "", :desc => "Fields to use in in bulk edit, comma separated"
      class_option :no_bulk, :type => :boolean, :default => false, :desc => "No bulk edit needed"
      class_option :menu, :type => :string, :default => "", :desc => "Provide menu items which should be in sidebar. format: menu1:url,menu2:url"
      class_option :title_field, :type => :string, :default => "name", :desc => "Field name to use as title of each object"
      class_option :required, :type => :string, :default => "", :desc => "Non optional fields, comma separated"
      class_option :deps, :type => :string, :default => "", :desc => "Dependencies of Angularjs module, comma separated"
      class_option :path, :type => :string, :default => "", :desc => "Path to js_scaffold target inside 'app/assets/javascripts/'"
      class_option :raw_path, :type => :string, :default => "", :desc => "Path to js_scaffold target"
      class_option :tabs, :type => :string, :default => "", :desc => "Add tabs to 'new' view of scaffold. format: --tabs tab1:'field1;field2',tab2 Note: __all__ field include all fileds."
      class_option :no_filter, :type => :boolean, :default => false, :desc => "Don't view a filter box"
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

      # Path to the resource
      def resource_path
        path_parts = resource_name.split("/")
        if path_parts.length > 1
          return "#{path_parts(0..-2).join("/")}/#{path_parts[-1].underscore}"
        end
        resource_name.underscore
      end

      # Url of resource
      def resource_url
        path_parts = resource_name.split("/")
        if path_parts.length > 1
          return "#{path_parts(0..-2).join("/")}/#{path_parts[-1].pluralize.underscore}"
        end
        resource_name.pluralize.underscore
      end

      def resource
        path_parts = resource_name.split("/")
        if path_parts.length > 1
          return path_parts[-1].camelize
        end
        resource_name.camelize
      end

      def is_in_engine?
        false
      end

      def angularjs_app_path
        if options[:raw_path] != ""
          options[:raw_path]
        elsif options[:path] != ""
          "app/assets/javascripts/#{options[:path]}/"
        else
          path = Faalis::Engine.dashboard_js_manifest.split("/")[0..-2].join("/")
          "app/assets/javascripts/#{path}/"
        end
      end

      # Tabs ------------------------------------

      # Process the user provided tabs
      # @return a Hash of tabs like
      def tabs
        if options[:tabs].present?
          tabs = options[:tabs].split(",")
          result = {}
          tabs.each do |tab|
            name, fields = tab.split(":")
            fields_list = []
            unless fields.nil?
              fields_list = fields.split(";")
            end
            result[name] = fields_list
          end
          return result
        else
          {}
        end
      end

      def any_tabs?
        options[:tabs].present?
      end
      # -----------------------------------

      # An array of fields like
      # [name, type]
      def fields
        fields = []
        resource_fields.each do |field|
          name, type, to = field.split(":")
          if ["belongs_to", "has_many", "in"].include? type
            type = Relation.new(type, to)
          end

          fields << [name, type]
        end
        fields
      end

      def fields_hash
        Hash[fields]
      end

      def grid_fields
        fields
      end

      # Returns fields which is needed to be in bulk edit
      def bulk_edit_fields
        unless options[:bulk_fields].empty?
          bfields = options[:bulk_fields].split(",")
          fields = fields_hash
          bfields.each do |f|
            unless fields.include? f
              raise ::Exception.new "'#{f}' is not in scaffold fields."
            end
          end
          return bfields
        else
          return fields.keys
        end
      end

      # Return an string to use as a function parameters each
      # field appears as symbol
      def fields_as_params(relations: false)
        result = ""
        field_num = 0
        fields.each do |name, type|
          if relations
            if ["belongs_to"].include? type
              result += " :#{name}_id"
            else
              result += " :#{name}"
            end
            field_num += 1
            if field_num < fields.length
              result += ","
            end

          else
            unless ["belongs_to", "has_many"].include? type
              result += " :#{name}"
              field_num += 1
              if field_num < fields.length
                result += ","
              end
            end
          end

        end

        if result
          result = ",#{result}"
          if result[-1] == ","
            result = result[0..-2]
          end
        end

        result
      end

      def parse_menu(menu)
        title, url = menu.split(":")
        model = nil
        if title.split(">").length > 1
          title, model = title.split(">")
        end
        return title, url, model
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

      def required_fields
        if not options[:required].empty?
          return options[:required].split(",")
        end
        []
      end
      class Relation < String
        attr_accessor :to

        def initialize(value, to_)
          super(value)
          self.to = to_
        end

        def resource_name
          to.split("/").last
        end

        def restangular
          result = "API"
          to.split("/").each do |resource|
            result = "#{result}.all(\"#{resource}\")"
          end
          result
        end

        def get_list
          "#{restangular}.getList()"
        end
      end
    end
  end
end
