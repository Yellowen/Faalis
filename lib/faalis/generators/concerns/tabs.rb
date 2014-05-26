require 'set'

module Faalis
  module Generators
    module Concerns
      # Using this **concern** module user can specify an array of tab objects
      # which each one has an `id` and `name` attribute. Tabs will be added to
      # **new** view of resource. Also this concern will a `tab` key to field
      # object. All the fields with same `id` as a tab will be grouped in that
      # tab
      module Tabs

        private
        # Process the user provided tabs
        # @return a Hash of tabs like
        def tabs
          tabbed_fields = Set.new

          if resource_data.include? 'tabs'

            tabs = resource_data['tabs']
            result = {}
            tabs.each do |tab|
              name = tab['name']
              fields_list = fields_with('tab', tab['id'])
              fields_list.each do |f|
                tabbed_fields << f
              end
              result[name] = fields_list
            end
            all_fields = Set.new resource_data['fields']

            result.each do |k, v|
              if v.empty?
                diff = (all_fields ^ tabbed_fields).to_a
                result[k] = diff
              end
            end
            return result
          else
            {}
          end
        end

        def tab_has_field?(tab_name, field_name)
          it_does = tabs[tab_name].select do |f|
            f['name'] == field_name
          end
          !it_does.empty?
        end

        def any_tabs?
          resource_data.include? 'tabs'
        end

      end
    end
  end
end
