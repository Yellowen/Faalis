module Faalis
  module Generators
    module Concerns

      module Child

        private

        # check for child
        def child?
          if resource_data.include? 'childs'
            return true unless resource_data['childs'].nil?
          end
          false
        end


        # Return an array of resource childs
        def childs
          if child?
            resource_data['childs']
          else
            []
          end
        end


      end
    end
  end
end
