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


      def fetch_index_objects
        index_properties.scope(params)
      end

      def index_properties
        Faalis::Dashboard::DSL::Index.new(model)
      end

    private

      def _fields
        nil
      end

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
      def in_index
        index_props = Faalis::Dashboard::DSL::Index.new(model)

        unless block_given?
          fail ArgumentError, "You have to provide a block for 'in_index'"
        end

        yield index_props

        define_method(:index_properties) do
          return index_props
        end
      end
    end
  end
end
