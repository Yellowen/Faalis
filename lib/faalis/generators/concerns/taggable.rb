module Faalis
  module Generators
    module Concerns
      module Taggable
        #This module adds `taggable` key to json file which is an boolan
        #Taggable key need to add `acts-as-taggable-on` gem in gemfile of your project
        private

        def taggable?
          resource_data.include?('taggable') &&  !resource_data['taggable'].empty?
        end
      end
    end
  end
end
