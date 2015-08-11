module Faalis
  module Generators
    module Concerns
      # This concern will add `render` method to generators which load
      # template partials
      module Render

        private

        def render(source, &block)
          source  = File.expand_path(find_in_source_paths("#{source.to_s}.erb"))
          context = instance_eval('binding')

          content = ERB.new(::File.binread(source), nil, '-').result(binding)
          content = block.call(content) if block
          content
        end

      end
    end
  end
end
