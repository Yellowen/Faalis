module Faalis
  module Generators
    module Concerns
      module Tabs

        def self.included(base)
          # Add tabs to 'new' view of scaffold. format: --tabs tab1:'field1;field2',tab2 Note: __all__ field include all fileds.
          base.class_option :tabs, :type => :string, :default => "", :desc => "Add tabs to 'new' view of scaffold. format: --tabs tab1:'field1;field2',tab2 Note: __all__ field include all fileds."
        end

        private

        # Process the user provided tabs
        # @return a Hash of tabs like
        def tabs
          if options[:tabs].present?
            tabs = options[:tabs].split(",")
            result = {}
            tabs.each do |tab|
              name, fields = tab.split(":")
              fields_list = []
              unless fields.nil?
                fields_list = fields.split(";")
              end
              result[name] = fields_list
            end
            return result
          else
            {}
          end
        end

        def any_tabs?
          options[:tabs].present?
        end

      end
    end
  end
end
