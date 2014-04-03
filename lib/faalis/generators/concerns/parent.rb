module Faalis
  module Generators
    module Concerns

      # This **concern** adds the methods needed to support nested resource
      # in any dashboad generators. This module adds `parents` key to jsonfile
      # which is an array of resource parents in right order.
      # For example if we have a nested resource like:
      #
      # ```ruby
      # resources :blogs do
      #   resources :categories do
      #     resources :posts
      #   end
      # end
      # ```
      #
      # And we want to create an dashboard scaffold for `post` resource we have
      # to add `parent` key to our json file like this:
      #
      # ```json
      # ...
      # "parents": [
      #     "blog",
      #     "category"
      # ]
      # ...
      # ```
      # Please pay attention to singular form of name of parents in json defination
      module Parent

        private

        # check for parent
        def parent?
          if resource_data.include? "parents"
            unless resource_data["parents"].nil?
              return true
            end
          end
          false
        end

        # Remove the starting slash from the given parent path
        def trim_parent_path(path)
          path.gsub(/^\//, "")
        end

        # Return an array of resource parents
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
