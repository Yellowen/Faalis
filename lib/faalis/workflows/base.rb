module Faalis
  module Workflows

    # Base class for all the workflows in a `Faalis application`
    class Base

      attr_reader :id

      def initialize(model_instance)
        @id = model_instance.id
      end

      # class method to set the title of current workflow
      def self.title(name)
        #binding.pry
        @@title = name
      end

      # Getter for current workflow title
      def title
        @@title || self.class.to_s.underscore
      end


      def self.icon(icons)
      end

      def self.image(image)
      end

    end
  end
end
