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
            _childs = resource_data['childs']
            _childs.collect do |p|
              trim_child_path(p)
            end
          else
            []
          end
        end

      end
    end
  end
end
