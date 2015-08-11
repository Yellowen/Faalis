module Faalis
  module Generators
    module Concerns
      # This concern adds support for `PostgreSQL` Hstore
      # type to generators. So `hstore` fields will not work
      # on other databases or work differently. For example
      # We try to create a json from the key/values of `hstore`
      # field and store that to the corresponding field.
      module Hstore

        private

        def hstore_fields
          fields_with('type', 'hstore')
        end
      end
    end
  end
end
