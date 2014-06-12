# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
#    Copyright (C) 2012-2014 Yellowen
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
    # Generator responsible for `scaffold` generator
    class ScaffoldGenerator < Rails::Generators::Base
      include Faalis::Generators::Concerns::RequireFields
      include Faalis::Generators::Concerns::Parent
      include Faalis::Generators::Concerns::JsonInput
      include Faalis::Generators::Concerns::ResourceName
      include Faalis::Generators::Concerns::ResourceFields

      desc 'Create full faalis full scaffold'
      class_option :no_model
      class_option :no_route
      class_option :no_controller

      def create_scaffold
        if options.empty?
        end
        create_model
      end

      private
      def create_model
        result = []
        all_fields = []
        fields.each do |name, type, to|

          case type
          when "belongs_to"
            type_ = "integer"
            name_ = "#{to.singularize}_id"
            result << [name_, type_]
            puts "Dont forget to create relations of #{name} and #{to} models"
          when "text", "integer", "string"
            result << [name, type]
          end

          all_fields = result.collect do |x|
            x.join(":")
          end

        end
        all_fields = all_fields.join(" ")
        invoke("active_record:model", [resource_data["name"], "list_order:string", "name:string"], {migration: true, timestamps: true})
      end
    end
  end
end
