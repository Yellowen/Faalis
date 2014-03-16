module Faalis
  module Generators
    module Concerns
      module Bulk

        def self.included(base)
          # Fields to use in in bulk edit, comma separated
          #base.class_option :bulk_fields, :type => :string, :default => "", :desc => "Fields to use in in bulk edit, comma separated"

          # No bulk edit needed
          #base.class_option :no_bulk, :type => :boolean, :default => false, :desc => "No bulk edit needed"
        end

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
