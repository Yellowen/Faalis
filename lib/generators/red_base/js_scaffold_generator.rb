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
      source_root File.expand_path('../templates', __FILE__)

      argument :resource_name, :type => :string, :required => true
      argument :fields, type: :array, default: [], banner: "fields[:types]"

      desc "Create a new resource for client side application"
      def create_module
        template "angularjs/module.js.erb", "#{angularjs_app_path}modules/#{resource_path}.js"
      end

      def create_template
        template "angularjs/index.html.erb", "app/assets/templates/#{resource.underscore}/index.html"
        template "angularjs/new.html.erb", "app/assets/templates/#{resource.underscore}/new.html"
      end

      private

      def resource_path
        path_parts = resource_name.split("/")
        if path_parts.length > 1
          return "#{path_parts(0..-2).join("/")}/#{path_parts[-1].underscore}"
        end
        resource_name.underscore
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
    end
  end
end
