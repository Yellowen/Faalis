module Faalis
  module Helpers
    module AutoloadHelper

      def self.extended(mod)
        def mod.autoload_helper(name, mod)
          define_method name, ->(*args) do
            puts "define_method"
            return send("__#{name}", *args) if method_defined? "__#{name}"
            mod.include mod.constantize
            alias_method "__#{name}", name
            #remove_method :delay
            send("__#{name}", *args)
          end
        end

      end

    end
  end
end
