require 'json'


module Faalis
  module Generators
    module Concerns
      # This module Provide an argument for generator which
      # is needed by other `Concerns`.
      #
      # Each Concern will have its own

      module JsonInput

        def self.included(base)
          # Name of the resource to create.
          base.argument :jsonfile , :type => :string, :required => true
        end

        private

        def json_file_data
          path = File.expand_path(jsonfile)
          File.read(path)
        end

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
