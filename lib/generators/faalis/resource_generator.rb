module Faalis
  module Generators
    # Generate a resource on dashboard
    class ResourceGenerator < Rails::Generators::Base

      desc 'Generates new Faalis resource.'
      argument :resource_name , type: :string, required: true
      class_option :namespace, desc: 'The parent namespace'

      source_root File.expand_path('../templates', __FILE__)

      def create_pundit_file
        generate 'pundit:policy', resource
      end

      def create_controller
        template('dashboard/controller.rb.erb',
                 "app/controllers/#{namespace.underscore + '/'}dashboard/#{resources}_controller.rb")
      end

      def inject_routes
        gsub_file('config/routes.rb',
                  "in_dashboard do",
                  "in_dashboard do\n    resources :#{resources}")
      end

      private

      def resource
        resource_name.singularize.underscore
      end

      def resources
        resource_name.pluralize.underscore
      end

      def namespace
        options["namespace"] || ''
      end
    end
  end
end
