module Faalis
  module Generators
    module Concerns
      module Angular

        def self.included(base)
          # Path to js_scaffold target inside 'app/assets/javascripts/'
          base.class_option :path, :type => :string, :default => "", :desc => "Path to js_scaffold target inside 'app/assets/javascripts/'"

          # Path to js_scaffold target
          base.class_option :raw_path, :type => :string, :default => "", :desc => "Path to js_scaffold target"
        end

        private


        def angularjs_app_path
          if options[:raw_path] != ""
            options[:raw_path]
          elsif options[:path] != ""
            "app/assets/javascripts/#{options[:path]}/"
          else
            path = Faalis::Engine.dashboard_js_manifest.split("/")[0..-2].join("/")
            "app/assets/javascripts/#{path}/"
          end
        end

      end
    end
  end
end
