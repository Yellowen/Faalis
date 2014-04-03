module Faalis
  module Generators
    module Concerns
      # This **concern** adds support of side menu to scaffold and `menu` key
      # to jsonfile. `menu` key is an array which each element represent a menu
      # entry and should be and object with following keys:
      #
      # `title`: Title of submenu
      #
      # `url`: Url of submenu link
      #
      # `action`: Permissions related action to check on resource model.
      #
      # `model`: Model of related resource which permission action should be check
      #          against.
      module Menu

        private

        def has_menu?
          resource_data.include? "menu"
        end

      end
    end
  end
end
