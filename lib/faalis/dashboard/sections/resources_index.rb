require_dependency 'faalis/dashboard/dsl/index'

module Faalis::Dashboard::Sections
  module ResourcesIndex

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def index
      authorize model

      fetch_and_set_all
      setup_named_routes

      return if _override_views.include? :index
      render 'faalis/dashboard/resource/index'
    end

    protected

      # Fetch all or part of the corresponding resource
      # from data base with respect to `scope` DSL
      def fetch_index_objects
        scope = index_properties._default_scope

        puts "<<<<<<<<<<<<<<", scope, model, policy_scope(model.page(params[:page]))
        return policy_scope(model.page(params[:page])) if scope.nil?

        if scope.respond_to? :call
          return scope.call.page(params[:page])
        else
          return self.send(scope, true).page(params[:page])
        end
      end

      def index_properties
        Faalis::Dashboard::DSL::Index.new(model)
      end

    private
      def fetch_and_set_all
        result = fetch_index_objects
        instance_variable_set("@#{plural_name}", result)

        @index_fields = index_properties.fields
        @resources    = result
      end

    # The actual DSL for index ages
    module ClassMethods

      # To specify any property and action for `index` section
      # you must use `in_index` class method with block of
      # properties. For example:
      #
      #   class ExamplesController < Dashboard::Application
      #     in_index do
      #       attributes :name, :description
      #       action_button :close, dashboard_example_close_path
      #     end
      #   end
      def in_index(&block)
        model = controller_name.classify.constantize
        index_props = Faalis::Dashboard::DSL::Index.new(model)

        unless block_given?
          fail ArgumentError, "You have to provide a block for 'in_index'"
        end

        index_props.instance_eval(&block) if block_given?

        define_method(:index_properties) do
          return index_props
        end
      end
    end
  end
end
