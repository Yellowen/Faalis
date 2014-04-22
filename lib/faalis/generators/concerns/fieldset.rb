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
          fields - fields_with_attribute("fieldset")
        end

      end
      def fieldsets
        fieldsets = {resource.underscore.pluralize.humanize => fieldset_less_fields}
        fields = fields_with_attribute("fieldset")
        fields.each do |f|
          if fieldsets.include? f["fieldset"]
            fieldsets[f["fieldset"]] << f
          else
            fieldsets[f["fieldset"]] = [f]
          end
        end
        fieldsets
      end
    end
  end
end
