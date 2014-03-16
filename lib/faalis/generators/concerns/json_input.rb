require 'json'


module Faalis
  module Generators
    module Concerns
      # This module Provide an argument for generator which
      # is needed by other `Concerns`.
      # Each Concern will have its own entry in scaffold json
      # file. For documentation on each entry checkout its concern class
      module JsonInput

        def self.included(base)
          # Name of the resource to create.
          base.argument :jsonfile , :type => :string, :required => true
        end

        private

        # Read the json file and returns its raw data
        def json_file_data
          path = File.expand_path(jsonfile)
          File.read(path)
        end

        # Return the hash related to json structure from cache or by
        # reading file.
        def resource_data
          if @data
            @data
          else
            @data = JSON.parse(json_file_data)
            @data
          end
        end


      end
    end
  end
end
