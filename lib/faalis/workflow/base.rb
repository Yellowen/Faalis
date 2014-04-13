module Faalis
  module Workflow

    # Base class for all the workflows in a `Faalis application`
    class Base

      def title
        binding.pry
        self.class.to_s.underscore
      end
    end
  end
end
