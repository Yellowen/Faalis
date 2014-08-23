module Faalis
  module Extension
    # This module provide basic functionallity of a Faalis extension
    # to a rails engine.
    module Base

      def included(base)
        extend ClassMethods
      end

      class ClassMethods
        def register_extension(name, klass)
          # TODO: Replace this mechanism with more elegant one
          #       For example use [] method or someting
          Faalis::Extension.extensions[name] = klass
        end

        # This method tells faalis that this extension will override
        # the generators templates of faalis from `template_path` location
        def override_generator_templates(template_path)
          send(:define_singleton_method, 'generator_templates_path') do
            template_path
          end
        end
      end
    end
  end
end
