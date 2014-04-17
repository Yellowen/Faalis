module Faalis
  module Workflows

    # Base class for all the workflows in a `Faalis application`
    class Base

      def self.title(name)
        #binding.pry
        self.class.to_s.underscore
      end

      def self.icon(icons)
      end

      def self.image(image)
      end

    end
  end
end
