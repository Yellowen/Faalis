module Faalis
  module Generators
    module Concerns
      module Dependency

        def self.included(base)
          # Dependencies of Angularjs module, comma separated
          base.class_option :deps, :type => :string, :default => "", :desc => "Dependencies of Angularjs module, comma separated"
        end

      end
    end
  end
end
