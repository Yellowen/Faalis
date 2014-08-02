module Faalis
  module Extension
    # Base class for all the Faalis extensions. This class
    # is a subclass of `Rails::Engine` that provides more means
    # to work with Faalis.
    class Base < ::Rails::Engine

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
