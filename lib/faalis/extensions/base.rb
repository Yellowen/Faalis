module Faalis
  module Extension
    # This module provide basic functionallity of a Faalis extension
    # to a rails engine.
    module Base

      def self.register_extension(name, klass)
        Faalis::Extension.extensions[name] = klass
      end

      def self.override_generator_templates(template_path)
        send(:define_singleton_method, 'generator_templates_path') do
          template_path
        end
      end
    end
  end
end
