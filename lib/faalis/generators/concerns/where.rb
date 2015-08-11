module Faalis
  module Generators
    module Concerns

      # This module is dedicated to filter resource object based
      # on a condition or query. For example if you want to filter
      # a resource objects to those which belongs to current logged
      # in user you can do like:
      #
      # ```javascript
      # ...
      # "where": {
      #     "user": "current_user"
      # }
      # ...
      # ```
      #
      # `where` value is an object which each key is a ruby model
      # field name and its value is the actual value that you want
      # to use to check the field against that.
      module Where
        private

        def where_cond?
          if resource_data.include? 'where'
            return true unless resource_data['where'].empty?
          end
          false
        end

        # Return a hash of parameters to pass to where method
        def where_conditions
          if has_where_cond?
            flat_array = resource_data['where'].map do |field, value|
              [field.to_sym, value]
            end
            Hash[flat_array]
          end
          {}
        end
      end
    end
  end
end
