module Faalis
  module Generators
    module Concerns
      module Parent

        def self.included(base)
          # Specify the parent resource if there was any
          #base.class_option :parents, :type => :string, :default => "", :desc => "Specify the parent resource if there was any"
        end

        private

        # check for parent
        def parent?
          unless resource_data["parents"].empty?
            return true
          end
          false
        end

        # Remove the starting slash from the given parent path
        def trim_parent_path(path)
          path.gsub(/^\//, "")
        end

        def parents
          if parent?
            _parents = resource_data["parents"]
            _parents.collect do |p|
              trim_parent_path(p)
            end
          else
            []
          end
        end

      end
    end
  end
end
