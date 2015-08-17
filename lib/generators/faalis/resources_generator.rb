module Faalis
  module Generators
    # Generate a resource on dashboard
    class ResourcesGenerator < Rails::Generators::Base

      desc 'Generates bunch of Faalis resource at once.'
      argument :resources , type: :array, required: true
      source_root File.expand_path('../templates', __FILE__)

      def generate_resources
        resources.each do |resource|
          generate 'faalis:resource', resource
        end
      end

      private

    end
  end
end
