module Faalis
  module Generators
    module Concerns

      # Adds `required` key to `fields`. Fields with this key as true will
      # be non optional fields
      module RequireFields

        private

        def required_fields
          # Returnes an array contains name of all fields with require = true
          fields_with('required', true).collect {|x| x['name']}
        end
      end
    end
  end
end
