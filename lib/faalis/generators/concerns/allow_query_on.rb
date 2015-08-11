module Faalis
  module Generators
    module Concerns
      # This module adds `allow_query_on` key to json file which is an array
      # of field name which you want to whitelist for query.
      module AllowQueryOn

        private

        def allowed_fields
          if allowed_fields_provided?
            unless resource_data['allow_query_on'].is_a? Array
              fail Exception.new 'value of `allow_query_on` key should be an Array. '
            end
            # :#{something} is a trick to convert the field name to sym on
            # controller
            fields = resource_data['allow_query_on'].collect { |f| ":#{f}" }
            fields.join(' ,')
          else
            []
          end
        end

        # Check for any allowed fields in json
        def allowed_fields_provided?
          if resource_data.include? 'allow_query_on'
            return true unless resource_data['allow_query_on'].nil?
          end
          false
        end
      end
    end
  end
end
