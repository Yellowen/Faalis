require_dependency 'faalis/dashboard/dsl/show'

module Faalis::Dashboard::Sections
  module ResourceShow

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def show
      @resource = model.find(params[:id])
      authorize @resource

      setup_named_routes
      collect_model_fields_for_show

      @resource_title     = _resource_title.singularize

      return if _override_views.include? :show
      render 'faalis/dashboard/resource/show'
    end

    protected

      def collect_model_fields_for_show
        @_fields ||= show_properties.fields
        valid_columns = all_valid_columns_for_show
      end

      def show_properties
        Faalis::Dashboard::DSL::Show.new(model)
      end

    private


      def all_valid_columns_for_show
        return @all_valid_columns_for_show unless @all_valid_columns_for_show.nil?
        columns   = model.columns_hash.dup
        relations = model.reflections

        relations.keys.each do |name|
          col    = relations[name]
          column = columns.delete col.foreign_key
          columns[name] = column
        end

        @all_valid_columns_for_show = columns
      end

      def _show_fields
        all_valid_columns_for_show.keys.map(&:to_sym)
      end

    # The actual DSL for index ages
    module ClassMethods
      # User can provides the fields that he/she wants to be shown
      # in the resource preview
      # for example:
      #
      # class Dashboard::PostsController < Dashboard::ApplicationController
      #   show_fields :title, created_at
      # end
      def show_fields(*fields, **options)
        define_method(:_new_form_fields) do
          fields.map(&:to_sym)
        end

        private :_show_fields
      end

      # To specify any property and action for `show` section
      # you must use `in_index` class method with block of
      # properties. For example:
      #
      # ```ruby
      #   class ExamplesController < Dashboard::Application
      #     in_show do
      #       attributes :name, :description
      #       action_button :close, label: 'Close', href: dashboard_example_close_path
      #     end
      #   end
      # ```
      #
      def in_show(&block)
        model = controller_name.classify.constantize
        show_props = Faalis::Dashboard::DSL::Show.new(model)

        unless block_given?
          fail ArgumentError, "You have to provide a block for 'in_show'"
        end

        show_props.instance_eval(&block) if block_given?

        define_method(:show_properties) do
          unless defined? @__show_props__
            instance_exec(show_props, &block)
            @__show_props__ = show_props
          end
          return @__show_props__
        end
      end
    end
  end
end
