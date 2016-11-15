require_dependency 'faalis/dashboard/dsl/base'

module Faalis::Dashboard::DSL
  class Create < Base

    def initialize(model)
      super
      @field_details = {}
    end

    # Specify attributes details, for example if you want to change a datetime
    # field type to string you need to do like this:
    #
    #  in_form do
    #    attributes_properties date: { as: :string }
    #  end
    def attributes_properties(**options)
      options_set = Set.new options.keys.map(&:to_s)

      unless options_set.subset? Set.new(@fields)
        fail "You have to provide correct attribute names in" +
             "'attributes_properties' for '#{@model}'."
      end

      # TODO: Check for valid value for each key
      @field_details = options || {}
    end

    def _field_details
      details = @field_details.dup

      fields_for_form.each do |field|
        if !details.include? field.to_sym

          type = guess_field_type(field)
          details[field.to_sym] = initialize_field(field.to_sym, type)
        end
      end

      details
    end

    def fields_for_form
      fields_name = @fields.dup

      fields_name.delete('id')
      fields_name.delete('created_at')
      fields_name.delete('updated_at')

      fields_name
    end

    private

      def guess_field_type(field)
        column = model.columns_hash[field.to_s]
        return column.type.to_sym unless column.nil?

        return :file if has_attachment? field.to_sym

        has_many                = ActiveRecord::Reflection::HasManyReflection
        has_and_belongs_to_many = ActiveRecord::Reflection::HasAndBelongsToManyReflection
        reflection              = model.reflections[field.to_s]

        unless reflection.nil?
          return nil if reflection.is_a? has_many
          return :multiple_select if reflection.is_a? has_and_belongs_to_many
          :select
        end
      end

      def has_attachment?(name)
        if model.respond_to? :attachment_definitions
          return true if model.attachment_definitions.keys.include? name
        end

        false
      end

      def initialize_field(name, type)
        if respond_to?("setup_#{type}".to_sym, true)
          return send("setup_#{type}", name)
        end
        { as: type.to_sym }
      end

      def setup_datetime(name)
        { as: :string,
          input_html: { class: 'datetimepicker' }
        }
      end

      def setup_time(name)
        { as: :string,
          input_html: { class: 'timepicker' }
        }
      end

      def setup_date(name)
        { as: :string,
          input_html: { class: 'datepicker1' }
        }
      end

      def setup_multiple_select(name)
        { as: :select,
          input_html: { class: 'multiple select' }
        }
      end

      def setup_integer(name)
        { as: nil }
      end

  end
end
