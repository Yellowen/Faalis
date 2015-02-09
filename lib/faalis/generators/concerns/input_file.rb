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

        # Return absolute path to input file
        def file_path
          File.expand_path(input_file)
        end
        # Get the extension name of input file
        def extname
          File.extname(file_path)
        end

        # Read the json or yaml file and returns its raw data
        def input_file_data
          File.read(file_path)
        end

        # Return the hash related to json or yaml structure from cache or by
        # reading file.
        def resource_data
          if @data
            @data
          else
            @data = JSON.parse(input_file_data) if extname == '.json'
            @data = YAML.load_file(file_path) if extname == '.yml'
            @data
          end
        end

      end
    end
  end
end
