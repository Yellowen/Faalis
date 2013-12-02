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
    class JsScaffoldGenerator < Rails::Generators::Base

      include ActionView::Helpers::TextHelper

      source_root File.expand_path('../templates', __FILE__)

      argument :resource_name, :type => :string, :required => true
      argument :resource_fields, type: :array, default: [], banner: "fields[:types]"

      desc "Create a new resource for client side application"
      def create_module
        template "angularjs/module.js.erb", "#{angularjs_app_path}modules/#{resource_path}.js"
      end

      def create_template
        template "angularjs/index.html.erb", "app/assets/templates/#{resource.underscore}/index.html"
        template "angularjs/new.html.erb", "app/assets/templates/#{resource.underscore}/new.html"
        template "angularjs/details.html.erb", "app/assets/templates/#{resource.underscore}/details.html"

        template "views/index.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/index.json.jbuilder"
        template "views/show.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/show.json.jbuilder"
        template "views/create.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/create.json.jbuilder"
        template "views/destroy.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/destroy.json.jbuilder"
        template "views/update.json.jbuilder.erb", "app/views/api/v1/#{resource.pluralize.underscore}/update.json.jbuilder"

      end

      def create_api
        template "api/controller.rb.erb", "app/controllers/api/v1/#{resource.pluralize.underscore}_controller.rb"
      end

      private

      def resource_path
        path_parts = resource_name.split("/")
        if path_parts.length > 1
          return "#{path_parts(0..-2).join("/")}/#{path_parts[-1].underscore}"
        end
        resource_name.underscore
      end

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
        path = RedBase::Engine.dashboard_js_manifest.split("/")[0..-2].join("/")
        "app/assets/javascripts/#{path}/"
      end


      def fields
        fields = []
        resource_fields.each do |field|
          name, type, to = field.split(":")
          if ["belongs_to", "has_many"].include? type
            type = Relation.new(type, to)
          end

          fields << [name, type]
        end
        fields
      end

      # Return an string to use as a function parameters each
      # field appears as symbol
      def fields_as_params
        result = ""
        field_num = 0
        fields.each do |name, type|

          unless ["belongs_to", "has_many"].include? type
            result += " :#{name}"
            field_num += 1
            if field_num < fields.length
              result += ","
            end
          end

        end
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
