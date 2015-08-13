module Faalis::Dashboard
  module ResourceDSL

    extend ActiveSupport::Concern

    def _resource_title
      _(controller_name.humanize)
    end

    protected
      def _resources
        instance_variable_get("@{plural_name")
      end

      def plural_name
        controller_name.underscore
      end

      def model
        controller_name.classify.constantize
      end

    private

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

      def setup_named_routes
        @engine      = _route_engine
        @index_route = guess_index_route
        @new_route   = guess_new_route
        @show_route  = guess_show_route
        @edit_route  = guess_edit_route
      end

    # The actual DSL for resource ages
    module ClassMethods
      # Via this method user can specify the engine or application name
      # which current resource is defined under. Default value is:
      # Rails.application
      def route_engine(name, &block)
        define_method(:_route_engine) do
          return block.call if block_given?
          name
        end
      end

      # Via this method user can specify the name of current resource
      # scope, Default value is `dashboard`
      def route_scope(name, &block)
        define_method(:_route_scope) do
          return block.call if block_given?
          name
        end
      end
    end

  end
end
