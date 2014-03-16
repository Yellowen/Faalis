module Faalis
  module Generators
    module Concerns
      module Angular

        def self.included(base)
          # Path to js_scaffold target inside 'app/assets/javascripts/'
          #base.class_option :path, :type => :string, :default => "", :desc => "Path to js_scaffold target inside 'app/assets/javascripts/'"

          # Path to js_scaffold target
          #base.class_option :raw_path, :type => :string, :default => "", :desc => "Path to js_scaffold target"
        end

        private


        def angularjs_app_path
          if not resource_data["raw_path"].blank?
            resource_data["raw_path"]
          elsif not resource_data["path"].blank?
            "app/assets/javascripts/#{resource_data['path']}/"
          else
            path = Faalis::Engine.dashboard_js_manifest.split("/")[0..-2].join("/")
            "app/assets/javascripts/#{path}/"
          end
        end

      end
    end
  end
end
