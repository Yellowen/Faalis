require 'faalis/generators/fields/relation'

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

        private

        # An array of fields like
        # [name, type]
        def fields(fields_source = resource_data['fields'])
          fields = []
          relations = ['belongs_to', 'has_many']

          if fields?
            fields_source.each do |field|
              name = field['name']
              type = field['type']
              to = field['to']
              options = field['options'] || {}

              type = Relation.new(type, to, options) if relations.include? type
              fields << [name, type, to]
            end
          end
          fields
        end

        # Return the value of `attr_name` of `field_name` in
        # resource_data["fields"]
        def attrs(field_name, attr_name)
          if fields?
            field = fields_with('name', field_name)[0]
            return field[attr_name]
          end
          nil
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
          # FIXME: cyclomatic complexity is to high
          result = ''
          field_num = 0

          fields.each do |name, type|
            if relations
              if ['belongs_to'].include? type
                result += " :#{name}_id"
              else
                result += " :#{name}"
              end

              field_num += 1
              result += ',' if field_num < fields.length

            else
              unless ['belongs_to', 'has_many'].include? type
                result += " :#{name}"
                field_num += 1
                result += ',' if field_num < fields.length
              end
            end
          end

          if result
            result = ",#{result}"
            result = result[0..-2] if result[-1] == ','
          end

          result
        end

        def raw_fields_data
          resource_data['fields'] || []
        end

        def fields_with(attr, value)
          raw_fields_data.select do |f|
            if f.include? attr
              f[attr] == value ? true : false
            else
              false
            end
          end
        end

        def fields_with_attribute(attr)
          field_list = raw_fields_data.select do |f|
            f.include?(attr) ? true : false
          end
          field_list
        end

        def no_filter?
          resource_data.include?('no_filter') &&  resource_data['no_filter']
        end

        def no_duplicate?
          resource_data.include?('no_duplicate') &&  resource_data['no_duplicate']
        end

        def fields?
          if resource_data.include? 'fields'
            return true unless resource_data['fields'].nil?
          end
          false
        end
      end
    end
  end
end
