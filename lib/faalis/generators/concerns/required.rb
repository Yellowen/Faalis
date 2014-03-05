module Faalis
  module Generators
    module Concerns
      module RequireFields

        def self.included(base)
          # Non optional fields, comma separated
          base.class_option :required, :type => :string, :default => "", :desc => "Non optional fields, comma separated"
        end

        private

        def required_fields
          if not options[:required].empty?
            return options[:required].split(",")
          end
          []
        end
      end
    end
  end
end
