require_dependency 'faalis/dashboard/dsl/index'

module Faalis::Dashboard::Sections
  module ResourcesIndex

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def index
      authorize model
      fetch_and_set_all
      action_buttons(index_properties)

      @_tools_buttons = index_properties.tool_buttons || {}
      index_hook(@resources)

      return if _override_views.include? :index
      render 'faalis/dashboard/resource/index'
    end

    protected

      # Fetch all or part of the corresponding resource
      # from data base with respect to `scope` DSL.
      #
      # The important thing here is that by using `scope`
      # DSL this method will chain the resulted scope
      # with other scopes like `page` and `policy_scope`
    def fetch_index_objects
      scope = index_properties.default_scope

        if !scope.nil?

          # If user provided an scope for `index` section.

          if scope.respond_to? :call
            # If scope provided by a block
            scope = scope.call
          else
            # If scope provided by a symbol
            # which should be a method name
            scope = self.send(scope)
          end

        else
          scope = model.all
          #scope = ApplicationPolicy::Scope.new(current_user, model.all).resolve
        end

        scope = scope.order('created_at DESC').page(params[:page])
        policy_scope(scope)

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

      # You can override this method to change the behaviour of `index`
      # action
      def index_hook(resources)

      end
    # The actual DSL for index ages
    module ClassMethods

      # To specify any property and action for `index` section
      # you must use `in_index` class method with block of
      # properties. For example:
      #
      # ```ruby
      #   class ExamplesController < Dashboard::Application
      #     in_index do
      #       attributes :name, :description
      #       action_button :close, label: 'Close', href: dashboard_example_close_path
      #     end
      #   end
      # ```
      #
      def in_index(&block)
        name  = controller_name
        path  = controller_path.gsub(name, '').gsub(/dashboard\//, '')
        model = "#{path}#{name}".classify.constantize

        index_props = Faalis::Dashboard::DSL::Index.new(model)

        unless block_given?
          fail ArgumentError, "You have to provide a block for 'in_index'"
        end

        define_method(:index_properties) do
          unless defined? @__index_props__
            instance_exec(index_props, &block)
            @__index_props__ = index_props
          end

          return @__index_props__
        end
      end

    end
  end
end
