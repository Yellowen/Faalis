module Faalis
  module Generators
    module Concerns
      module Bulk

        private

        # Returns fields which is needed to be in bulk edit
        def bulk_edit_fields
          fields_with("bulk", true)
        end

        def no_bulk?
          if bulk_edit_fields.length > 0
            true
          else
            false
          end
        end
      end
    end
  end
end
