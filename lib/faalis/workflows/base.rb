module Faalis
  module Workflows

    # Base class for all the workflows in a `Faalis application`
    class Base

      attr_reader :id

      @@default_values = {:title => self.class.to_s.underscore,
                          :icon => nil,
                          :image => nil,
                          :permissions => []}

      def initialize(model_instance)
        @id = model_instance.id
      end

      # class method to set the title of current workflow
      def self.title(name)
        define_method :title do
           name || self.to_s.underscore
        end
      end


      # Set the current workflow icon if any
      def self.icon(icon)
        define_method :icon do
           icon
        end
      end


      def icon?
        return true if defined? :icon
        false
      end


      # Set the current workflow image if any
      def self.image(image)
        define_method :image do
           image
        end
      end

      def image?
        return true if defined? :image
        false
      end

      # Use this class method to add any permission that is neeeded
      # for this workflow to work
      def self.permissions(*args)
        define_method :permissions do
           args || []
        end
      end

      def method_missing(m, *args, &block)
        if @@default_values.include? m
          @@default_values[m]
        else
          super
        end
      end

    end
  end
end
