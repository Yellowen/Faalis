module Faalis
  module Generators
    module Concerns
      module ResourceName

        def self.included(base)
          # Name of the resource to create.
          #base.argument :resource_name, :type => :string, :required => true
        end

        private

        # Path to the resource
        def resource_path
          path_parts = resource_data["name"].split("/")
          if path_parts.length > 1
            return "#{path_parts(0..-2).join("/")}/#{path_parts[-1].underscore}"
          end
          resource_data["name"].underscore
        end

        # Url of resource
        def resource_url
          path_parts = resource_data["name"].split("/")
          if path_parts.length > 1
            return "#{path_parts(0..-2).join("/")}/#{path_parts[-1].pluralize.underscore}"
          end
          resource_data["name"].pluralize.underscore
        end

        def resource
          path_parts = resource_data["name"].split("/")
          if path_parts.length > 1
            return path_parts[-1].camelize
          end
          resource_data["name"].camelize
        end

      end
    end
  end
end
