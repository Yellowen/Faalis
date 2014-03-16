module Faalis
  module Generators
    module Concerns
      module Menu

        def self.included(base)
          # Provide menu items which should be in sidebar. format: menu1:url,menu2:url
          #base.class_option :menu, :type => :string, :default => "", :desc => "Provide menu items which should be in sidebar. format: menu1:url,menu2:url"
        end

        private

        def has_menu?
          resource_data.include? "menu"
        end

      end
    end
  end
end
