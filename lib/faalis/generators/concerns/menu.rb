module Faalis
  module Generators
    module Concerns
      module Menu

        def self.included(base)
          # Provide menu items which should be in sidebar. format: menu1:url,menu2:url
          base.class_option :menu, :type => :string, :default => "", :desc => "Provide menu items which should be in sidebar. format: menu1:url,menu2:url"
        end

        private

        def parse_menu(menu)
          regex = /([^:{}]+){1}\:([^:\{\}]+)(?:{(.*)})?/i
          model = nil
          if menu =~ regex
            title = $1
            url = $2
            model = $3
            return title, url, model
          else
            Raise Exception.new "Menu items format should be like 'name:url{model}'. Model part is optional"
          end
        end

      end
    end
  end
end
