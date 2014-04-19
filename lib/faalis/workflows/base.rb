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
        instance_variable_set(:@title, name)
      end

      def title
        @title || self.class.to_s.underscore
      end

      # Set the current workflow icon if any
      def self.icon(icon)
        instance_variable_set(:@icon, icon)
      end

      # Getter for workflow icon
      def icon
        return @icon if defined? :@icon
        nil
      end

      def icon?
        return true if defined? :@icon
        false
      end


      # Set the current workflow image if any
      def self.image(image)
        instance_variable_set(:@image, image)
      end

      # Getter for the current workflow image
      def image
        return @image if defined? :@image
        nil
      end

      def image?
        return true if defined? :@image
        false
      end

      # Use this class method to add any permission that is neeeded
      # for this workflow to work
      def self.permissions(*args)
        instance_variable_set(:@permissions, args)
      end

      # permissions getter
      def permissions
        return @permissions if defined? @permissions
        []
      end

    end
  end
end
