module Faalis
  module Generators
    module Concerns

      # This **Concern** adds support of dependencies to scaffold using
      # `deps` key in json file. You can provide a list of scaffold dependencies
      # which should mention as dependecy of **Angularjs** module of scaffold.
      # Example:
      #
      #```javascript
      #   ....
      #   "deps": [
      #       "module1",
      #       "module2"
      #   ],
      #   ...
      #```
      module Dependency

        def self.included(base)
          # Dependencies of Angularjs module, comma separated
          #base.class_option :deps, :type => :string, :default => "", :desc => "Dependencies of Angularjs module, comma separated"
        end

        # Return a list of dependencies.
        def deps
          resource_data[:deps]
        end
      end
    end
  end
end
