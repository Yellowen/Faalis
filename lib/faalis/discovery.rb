module Faalis
  module Workflow
    class Discovery
      def self.build_table_list
        # Get all gem by requiring them
        all_gems = Bundler.require()

        # Discover all model files in gem files and load them
        all_gems.each do |gem|
          if gem.groups.include? Rails.env.to_sym or gem.groups.include? :default
            puts "Gem name: #{gem.name}"
            spec = Gem::Specification.find_by_name gem.name
            discover spec.gem_dir
          end
        end

        # Discover models in current rails app and load them
        discover Rails.root

        # Create a content type entry for all Models
        Faalis::Workflow::Base.subclasses.each do |workflow|
          Workflow.find_or_create_by(name: workflow.to_s)
        end
      end

      private

      def self.discover(path)
        Dir["#{path}/app/workflows/**/*.rb"].each do |workflow_file|
          puts "File matched: #{workflow_file}"
          load workflow_file
        end
      end
    end
  end
end
