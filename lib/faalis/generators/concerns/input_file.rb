require 'json'
require 'yaml'

module Faalis
  module Generators
    module Concerns
      # This module Provide an argument for generator which
      # is needed by other `Concerns`.
      # Each Concern will have its own entry in scaffold json
      # file. For documentation on each entry checkout its concern class
      module InputFile

        def self.included(base)
          # Name of the resource to create.
          base.argument :input_file , :type => :string, :required => true
        end

        private

        # Get the extension name of input file
        def extname
          path = File.expand_path(input_file)
          File.extname(path)
        end

        # Read the json or yaml file and returns its raw data
        def input_file_data
          path = File.expand_path(input_file)
          File.read(path)
        end

        # Return the hash related to json or yaml structure from cache or by
        # reading file.
        def resource_data
          if @data
            @data
          else
            @data = JSON.parse(input_file_data) if extname == '.json'
            @data = YAML.load_file(input_file_data) if extname == '.yml'
            @data
          end
        end

      end
    end
  end
end
