require "faalis/generators/fields/relation"


module Faalis
  module Generators
    module Concerns
      module ResourceFields

        def self.included(base)
          # An array of resource fields. fields should be separated by space
          # each filed should be in this format `field_name:field_type[:extra_info]
          base.argument :resource_fields, type: :array, default: [], banner: "fields[:types]"

        end

        private
        # An array of fields like
        # [name, type]
        def fields
          fields = []
          resource_fields.each do |field|
            name, type, to = field.split(":")
            if ["belongs_to", "has_many", "in"].include? type
              type = Relation.new(type, to)
            end

            fields << [name, type]
          end
          fields
        end

        def fields_hash
          Hash[fields]
        end

        def grid_fields
          fields
        end

        # Return an string to use as a function parameters each
        # field appears as symbol
        def fields_as_params(relations: false)
          patternt = /(?<name>[^:\{\}]+):(?<type>[^:\{\}]+)(?:\{(?<options>.+)\})*/
          result = ""
          field_num = 0
          fields.each do |name, type|
            if relations
              if ["belongs_to"].include? type
                result += " :#{name}_id"
              else
                result += " :#{name}"
              end
              field_num += 1
              if field_num < fields.length
                result += ","
              end

            else
              unless ["belongs_to", "has_many"].include? type
                result += " :#{name}"
                field_num += 1
                if field_num < fields.length
                  result += ","
                end
              end
            end

          end

          if result
            result = ",#{result}"
            if result[-1] == ","
              result = result[0..-2]
            end
          end

          result
        end

      end
    end
  end
end
