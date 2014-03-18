require "faalis/generators/fields/relation"


module Faalis
  module Generators
    module Concerns
      # This **concern** module is one of the most important **concerns** in
      # dashboard scaffold system. This module adds `fields` key to json file
      # which use for defining the resource fields. `fields` key is an array
      # of objects which each object represent a field. Each field have following
      # attributes:
      #
      # **name**: Name of field
      #
      # **type**: Type of field. some of the most important types are: `string`,
      #         `integer`, `flout`, `belongs_to`, `has_many`, `in`, `datetime`.
      #          For complete list of types take a look at
      #          `app/assets/javascripts/faalis/dashboard/modules/fields/`
      #
      # **to**: This attribute is just for `in`, `has_many` and `belongs_to` field
      #       types which define the resource that current resource have dependency
      #       with. Bear in mind that `in` type uses `to` attrbute as an array of
      #       possible value for field and will render as a combobox.
      #
      # **options**: An object of type related objects. For example a list of
      #            current resource parents just like `parent` key.
      #
      # **bulk**: All fields with true as `bulk` value will be used in bulk editor.
      #
      # **tab**: ID of a Tab that this field should be appear on.
      #
      # **required**: Field will be non optional.
      module ResourceFields

        def self.included(base)
          # An array of resource fields. fields should be separated by space
          # each filed should be in this format `field_name:field_type[:extra_info]
          # Relation options should be like `{key: value, key2: elem1;elem2, key3: value3}`
          #base.argument :resource_fields, type: :array, default: [], banner: "fields[:types[:to[{relation_options}]"

        end

        private
        # An array of fields like
        # [name, type]
        def fields
          fields = []
          if have_fields?
            resource_data["fields"].each do |field|
              name = field["name"]
              type = field["type"]
              to = field["to"]
              options = field["options"] || {}

              if ["belongs_to", "has_many", "in"].include? type
                type = Relation.new(type, to, options)
              end

              fields << [name, type]
            end
          end
          fields
        end

        def fields_hash
          Hash[fields]
        end

        def grid_fields
          fields_with("view_in_grid", true)
        end

        # Return an string to use as a function parameters each
        # field appears as symbol
        def fields_as_params(relations = false)
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

        def raw_fields_data
          if have_fields?
            return resource_data["fields"]
          end
          []
        end

        def fields_with(attr, value)
          raw_fields_data.select do |f|

            if f.include? attr

              if f[attr] == value

                true
              else
                false
              end
            else
              false
            end

          end
        end

        def no_filter?
          resource_data.include?("no_filter") &&  resource_data["no_filter"]
        end

        def have_fields?
          if resource_data.include? "fields"
            unless resource_data["fields"].nil?
              return true
            end
          end
          false
        end
      end
    end
  end
end
