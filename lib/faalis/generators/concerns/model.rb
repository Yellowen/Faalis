module Faalis
  module Generators
    module Concerns
      # This **concern** adds support for `model` key inside jsonfile which
      # allow you to override the name of resource default model name.
      # Resource model name is used in some processes like permission system.
      module Model

        def self.included(base)
          # Fields to use in in bulk edit, comma separated
          #base.class_option :model, :type => :string, :default => "", :desc => "Model name to use"

        end

        private

        # Does an alternative `model` is specified ?
        def model_specified?
          resource_data.include? "model"
        end

        # Name of alternative `model`
        def model
          if model_specified?
            resource_data["model"]
          else
            ""
          end
        end

      end
    end
  end
end
