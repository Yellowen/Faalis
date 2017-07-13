require_dependency 'faalis/dashboard/dsl/show'

module Faalis::Dashboard::Sections
  module ResourceShow

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def show
      @resource = model.find(params[:id])
      authorize @resource

      collect_model_fields_for_show

      @resource_title = t(_resource_title.singularize)

      # list all the model names that have :has_many relation
      reflection_models = model.reflect_on_all_associations(:has_many).
        map(&:class_name)

      @reflection_controller = []

      if reflection_models.length > 0
        reflection_models.each do |mdl|
          @reflection_controller.push mdl.tableize.split('/')[-1]
        end
      end


      show_hook(@resource)

      return if _override_views.include? :show
      render 'faalis/dashboard/resource/show'
    end

    protected

      def collect_model_fields_for_show
        @_fields ||= show_properties.fields
        #valid_columns = all_valid_columns_for_show
      end

      def show_properties
        Faalis::Dashboard::DSL::Show.new(model)
      end

    private


      # def all_valid_columns_for_show
      #   return @all_valid_columns_for_show unless @all_valid_columns_for_show.nil?
      #   columns   = model.columns_hash.dup
      #   relations = model.reflections

      #   relations.keys.each do |name|
      #     col    = relations[name]
      #     column = columns.delete col.foreign_key
      #     columns[name] = column
      #   end

      #   @all_valid_columns_for_show = columns
      # end
      def _show_fields
        all_valid_columns_for_show.keys.map(&:to_sym)
      end

      # You can override this method to change the behaviour of `show`
      # action
      def show_hook(resource)
      end

    # The actual DSL for index ages
    module ClassMethods
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
        name  = controller_name
        path  = controller_path.gsub(name, '').gsub(/dashboard\//, '')
        model = "#{path}#{name}".classify.constantize
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
