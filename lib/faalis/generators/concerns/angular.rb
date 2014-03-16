module Faalis
  module Generators
    module Concerns

      # This **Concern** looks for `raw_path` and `path` in scaffold
      # json file which both of them are optional.
      # Using `raw_path` you can override the full path of generate file.
      # and with `path` you can override the directory name inside
      # `app/assets/javascripts`.
      module Angular

        def self.included(base)
          # Path to js_scaffold target inside 'app/assets/javascripts/'
          #base.class_option :path, :type => :string, :default => "", :desc => "Path to js_scaffold target inside 'app/assets/javascripts/'"

          # Path to js_scaffold target
          #base.class_option :raw_path, :type => :string, :default => "", :desc => "Path to js_scaffold target"
        end

        private

        # return the relative path to place where scaffold shoud be created.
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
