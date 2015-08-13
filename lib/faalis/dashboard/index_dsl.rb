module Faalis::Dashboard
  module IndexDSL

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
        model.all
      end

    private

      def _fields
        nil
      end

      def fetch_and_set_all
        result = fetch_index_objects
        instance_variable_set("@#{plural_name}", result)

        @index_fields = _fields || model.column_names
        @resources    = result
      end

    # The actual DSL for index ages
    module ClassMethods
      # User can provides the fields that he/she wants to be shown
      # in the index page. By default `to_s` method will call on
      # the field value.
      # for example:
      #
      # class Dashboard::PostsController < Dashboard::ApplicationController
      #   index_fields :title, created_at
      # end
      def index_fields(*fields)
        define_method(:_fields) do
          return fields
        end

        private :_fields
      end
    end
  end
end
