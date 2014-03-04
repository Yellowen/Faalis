module Faalis
  module Generators
    module Concerns
      module Bulk

        def self.included(base)
          # Fields to use in in bulk edit, comma separated
          base.class_option :bulk_fields, :type => :string, :default => "", :desc => "Fields to use in in bulk edit, comma separated"

          # No bulk edit needed
          base.class_option :no_bulk, :type => :boolean, :default => false, :desc => "No bulk edit needed"
        end

        private

        # Returns fields which is needed to be in bulk edit
        def bulk_edit_fields
          unless options[:bulk_fields].empty?
            bfields = options[:bulk_fields].split(",")
            fields_ = fields_hash
            bfields.each do |f|
              unless fields_.include? f
                raise ::Exception.new "'#{f}' is not in scaffold fields."
              end
            end
            return bfields
          else

            return self.send(:fields).collect {|f| f[0]}
          end
        end

      end
    end
  end
end
