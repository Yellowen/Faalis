module Faalis::Dashboard
  module IndexDSL

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def index
      authorize model

      fetch_and_set_result
      setup_named_routes

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

      def _route_name
        nil
      end

      def _route_engine
        Rails.application
      end

      def guess_index_route(scope  = 'dashboard')
        scope_ = "#{scope}_"
        "#{scope_}#{controller_name}_path"
      end

      def guess_show_route(scope  = 'dashboard')
        scope_        = "#{scope}_"
        resource_name = controller_name.singularize.underscore
        "#{scope_}#{resource_name}_path"
      end

      def guess_edit_route(scope  = 'dashboard')
        scope_        = "#{scope}_"
        resource_name = controller_name.singularize.underscore
        "edit_#{scope_}#{resource_name}_path"
      end

      def guess_new_route(scope  = 'dashboard')
        scope_        = "#{scope}_"
        resource_name = controller_name.singularize.underscore
        "new_#{scope_}#{resource_name}_path"
      end

      def guess_edit_route(scope  = 'dashboard')
        scope_        = "#{scope}_"
        resource_name = controller_name.singularize.underscore
        "edit_#{scope_}#{resource_name}_path"
      end

      def fetch_and_set_result
        result = fetch_index_objects
        instance_variable_set("@#{plural_name}", result)

        @index_fields = _fields || model.column_names
        @resources    = result
      end

      def setup_named_routes
        @engine      = _route_engine
        @index_route = guess_index_route
        @new_route   = guess_new_route
        @show_route  = guess_show_route
        @edit_route  = guess_edit_route
      end

    # The actual DSL for index ages
    module ClassMethods
      def index_fields(*fields)
        define_method(:_fields) do
          return fields
        end

        private :_fields
      end

      def route_engine(name, &block)
        define_method(:_route_engine) do
          return block.call if block_given?
          name
        end
      end

      def route_scope(name, &block)
        define_method(:_route_scope) do
          return block.call if block_given?
          name
        end
      end
    end
  end
end
