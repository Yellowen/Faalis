module Faalis
  module Generators
    module Concerns
      module RequireFields

        def self.included(base)
          # Non optional fields, comma separated
          #base.class_option :required, :type => :string, :default => "", :desc => "Non optional fields, comma separated"
        end

        private

        def required_fields
          fields_with("required", true)
        end
      end
    end
  end
end
