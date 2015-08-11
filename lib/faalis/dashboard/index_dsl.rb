module Faalis::Dashboard
  module IndexDSL

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def index
      puts "<<<<<<<<<" * 100, _fields
      authorize model
      result = fetch_index_objects
      instance_variable_set("@#{plural_name}", result)

      @index_fields = _fields || model.column_names
      @resources    = result

      return if _override_views.include? :index
      render 'faalis/dashboard/resource/index'
    end

    protected

      def _resources
        instance_variable_get("@{plural_name")
      end

      def plural_name
        controller_name.underscore
      end

      def fetch_index_objects
        model.all
      end

      def model
        controller_name.classify.constantize
      end

    private

      def _fields
        nil
      end


    module ClassMethods
      def index_fields(*fields)
        define_method(:_fields) do
          return fields
        end

        private :_fields
      end
    end
  end
end
