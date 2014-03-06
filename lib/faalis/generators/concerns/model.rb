module Faalis
  module Generators
    module Concerns
      module Model

        def self.included(base)
          # Fields to use in in bulk edit, comma separated
          base.class_option :model, :type => :string, :default => "", :desc => "Model name to use"

        end

        private

        def model_specified?
          not options[:model].empty?
        end

        def model
          if model_specified?
            options[:model]
          else
            ""
          end
        end

      end
    end
  end
end
