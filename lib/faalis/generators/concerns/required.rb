module Faalis
  module Generators
    module Concerns

      # Adds `required` key to `fields`. Fields with this key as true will
      # be non optional fields
      module RequireFields

        def self.included(base)
          # Non optional fields, comma separated
          #base.class_option :required, :type => :string, :default => "", :desc => "Non optional fields, comma separated"
        end

        private

        def required_fields
          fields_with("required", true).collect {|x| x["name"]}
        end
      end
    end
  end
end
