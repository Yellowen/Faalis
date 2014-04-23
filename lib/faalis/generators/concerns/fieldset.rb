require 'set'

module Faalis
  module Generators
    module Concerns
      # Allow to categorize fields in some fieldset
      module Fieldset

        private

        # Returns fields which is needed to be in bulk edit
        def fieldset?
          !fields_with_attribute("fieldset").empty?
        end

        def fieldset_less_fields
          fields = Set.new(raw_fields_data) - Set.new(fields_with_attribute("fieldset"))
          puts ">>>>>>>>>>>((((((((((((( #{fields.to_a}"
          fields.to_a
        end

        # TODO: fix this method to allow usage on tabbed views too
        # Return fields categorized by fieldsets. Only for
        # views without tabs
        def fieldsets
          fieldsets = {resource.underscore.pluralize.humanize => fieldset_less_fields}
          fields = fields_with_attribute('fieldset')
          fields.each do |f|
            if fieldsets.include? f['fieldset']
              fieldsets[f['fieldset']] << f
            else
              fieldsets[f['fieldset']] = [f]
            end
          end

          # Convert hashes to proper field structure to use in templates
          fieldsets.each do |fieldset_name, fieldset_fields|
            if fieldset_fields[0].is_a? Hash
              fieldsets[fieldset_name] = fields(fieldset_fields)
            end
          end

          fieldsets
        end
      end
    end
  end
end
