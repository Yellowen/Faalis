module Faalis
  module Generators
    module Concerns
      # This module adds `allow_query_on` key to json file which is an array
      # of field name which you want to whitelist for query.
      module AllowQueryOn

        private


        def allowed_fields
          if allowed_fields_provided?
            unless resource_data["allow_query_on"].is_a? Array
              raise Exception.new "value of `allow_query_on` key should be an Array. "
            end
            fields = resource_data["allow_query_on"].collect do |f|
              ":#{f}"
            end
            fields.join(" ,")
          else
            []
          end
        end

        # Check for any allowed fields in json
        def allowed_fields_provided?
          if resource_data.include? "allow_query_on"
            unless resource_data["allow_query_on"].nil?
              return true
            end
          end
          false
        end

      end
    end
  end
end
