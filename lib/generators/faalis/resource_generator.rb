module Faalis
  module Generators
    # Generate a resource on dashboard
    class ResourceGenerator < Rails::Generators::Base

      desc 'Generates new Faalis resource.'
      argument :resource_name , type: :string, required: true

      source_root File.expand_path('../templates', __FILE__)

      def create_pundit_file
        generate 'pundit:policy', resource
      end

      def create_controller
        template('dashboard/controller.rb.erb',
                 "app/controllers/#{module_path}dashboard/#{resources}_controller.rb")
      end

      def inject_routes
        gsub_file('config/routes.rb',
                  "in_dashboard do",
                  "in_dashboard do\n    resources :#{resources}")
      end

      def warning
        unless module_name.blank?
          puts ""
          puts "[Warning] : Please fix your routes. Since you're using a resource inside"
          puts "            a namespace, you have to fixed your routes to point to your"
          puts "            new generate code. For example if you create a resource like"
          puts "            `School::Student`, then you should have your route like this:"
          puts ""
          puts "            in_dashboard do"
          puts "               scope :school do"
          puts "                  resources students"
          puts "               end"
          puts "            end"
          puts ""
        end
      end
      private

      def module_name
        resource_name.underscore.split('/')[0..-2].join('/')
      end

      def module_path
        if !module_name.blank?
          module_name + '/'
        else
          ''
        end
      end

      def controller_module
        path = module_path + 'dashboard/'
        path.classify
      end

      def resource
        resource_name.underscore.split('/')[-1].singularize
      end

      def resources
        resource.pluralize
      end
    end
  end
end
