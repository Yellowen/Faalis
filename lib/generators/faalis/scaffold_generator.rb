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
    # Generator Full Faalis scaffold with dashboard
    class ScaffoldGenerator < Rails::Generators::Base
      include Faalis::Generators::Concerns::RequireFields
      include Faalis::Generators::Concerns::Parent
      include Faalis::Generators::Concerns::Child
      include Faalis::Generators::Concerns::JsonInput
      include Faalis::Generators::Concerns::ResourceName
      include Faalis::Generators::Concerns::ResourceFields
      include Faalis::Generators::Concerns::Globalize


      desc 'Create full faalis full scaffold'
      # FIXME: These options should have :desc or even default
      #        value
      class_option :no_model, :type => :boolean
      class_option :no_route, :type => :boolean
      class_option :no_controller, :type => :boolean
      class_option :no_migration, :type => :boolean
      class_option :no_asset, :type => :boolean

      # This method will create full scaffold based on user options
      def create_scaffold
        if options.empty?
          # TODO: ....
        end
        # TODO: Show error if in class_option migration is selected by model not
        create_model unless options[:no_model]
        create_route unless options[:no_route]
        create_controller unless options[:no_controller]
        create_list_view
      end

      private

      # Create a dedicated controller,
      # It does not have any relation to Faalis
      # TODO: Check for better way
      def create_controller
        if options[:no_asset]
          `rails g scaffold_controller #{resource_data["name"]} --skip`
        else
          `rails g scaffold_controller #{resource_data["name"]}`
        end
      end

      # Create route of the scaffold in config/routes.rb
      def create_route
        route "resources :#{resource_data["name"].pluralize}"
      end

      #Create model of the scaffold with belongs_to support
      #It does not support has_many relation yet
      def create_model
        result = []
        all_fields = []
        relations = "\n"

        fields.each do |name, type, to|
          case type
          when 'belongs_to'
            type_ = 'integer'
            if to.singularize != name
              relations << "  belongs_to :#{name.singularize},
              :class_name => \"#{to.singularize.capitalize}\"\n"
            else
              relations << "  belongs_to :#{to.singularize}\n"
            end
            name_ = "#{name.singularize}_id"
            result << [name_, type_]

          when 'text', 'integer', 'string', 'boolean', 'datetime', 'date', 'float'
            result << [name, type]

          when 'image'
            generate "paperclicp #{resource_data['name']} #{name}"
            relations << "  has_attached_file :#{name}\n"
            relations << "  validates_attachment_content_type :#{name},
     content_type: %w(image/jpeg image/jpg image/png),
     less_than:  1.megabytes]\n"
            # TODO: Run this generator just once for all images
            `rails generate paperclip #{resource_data['name']} #{name}`
          when 'tag'
            rake "rake acts_as_taggable_on_engine:install:migrations"
            relations << "  acts_as_taggable_on :#{name}\n"
            result << [name, 'string']

          when 'in'
            result << [name, 'string']

          when 'has_many'
            relations << "  has_and_belongs_to_many :#{to}\n"
            say_status 'warn', "There is a many to many relation between #{resource_data['name']} and #{to},
 You should create it manually in model files"

          end
        end

        if parent?
          parents.each do |parent|
            result << ["#{parent.singularize}_id", "integer"]
            relations << "  belongs_to :#{parent.singularize}\n"
          end
        end


        childs.each do |child|
          relations << "  has_many :#{child.pluralize}\n"
        end

        all_fields = result.collect do |x|
          x.join(':')
        end

        # Load all globalize field and create a string to adding in model
        globalizes = "\n  translates "+
          globalize_fields.map { |field | ":#{field['name'].underscore}" }.join(", ")



        invoke('active_record:model', [resource_data['name'].underscore, *all_fields], {
                 migration: !options[:no_migration], timestamps: true
               })
        if globalize_fields.any?
          create_globalize_migration
        end

        if File.exist?("app/models/#{resource_data["name"]}.rb")

          inject_into_file "app/models/#{resource_data["name"].underscore}.rb", after: 'Base' do

            globalize_fields.empty? ? relations : relations + globalizes
          end
        else
          puts "Could not find file app/models/#{resource_data["name"].underscore}"
        end



      end

      #Invoke Faalis list view generator
      def create_list_view
        invoke 'faalis:js:list_view', [jsonfile]

      end

      def create_globalize_migration
        `rails g migration add_globalize_to_#{resource_data["name"].underscore} `
        Dir["#{Rails.root}/db/migrate/**/*globalize*.rb"].each {|file| require file }
        klass = "add_globalize_to_#{resource_data['name']}".underscore.camelize

        migration_class = "::#{klass}".constantize
        migration_path = migration_class.instance_method(:change).source_location

        fields = globalize_fields.map { |field | ":#{field['name']} => :#{field['type']}" }.join(", ")

        inject_into_file migration_path[0], after: 'change' do
          "\n    #{resource_data['name'].camelize}"+
            '.create_translation_table! '+
            fields
        end
      end
    end
  end
end
