module Faalis::Dashboard::Sections
  module Resource

    extend ActiveSupport::Concern

    included do |base|
      base.before_action :setup_named_routes
    end

    def _resource_title
      t(controller_name.humanize)
    end

    protected

      def _resources
        instance_variable_get("@{plural_name")
      end

      def plural_name
        controller_name.underscore
      end

      def model_name
        controller_path.gsub('dashboard/', '').classify
      end

      def model
        "::#{model_name}".constantize
      rescue
        msg = "Can't find model '::#{model_name}'. Please override \
              'model' method in your dashboard controller."
        fail NameError, msg
      end

      def namespace
        pieces = controller_path.gsub('dashboard/', '').split('/')
        return '' if pieces.length == 1
        pieces.pop
        pieces.join('/')
      end

      def _route_engine
        if namespace.empty?
          Rails.application
        else
          "#{namespace.split('/')[0]}::Engine".classify.constantize
        end
      end

      # Return the array of action buttons in given `property_object`.
      # `property_object` is an instance of once of DSL classes.
      def action_buttons(property_object)
        @_action_buttons = property_object.action_buttons || []
      end

    private

      def _route_name
        nil
      end

      def attachment_fields
        if model.respond_to? :attachment_definitions
          return model.attachment_definitions.keys
        end

        []
      end

      def has_attachment?
        !attachment_fields.empty?
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
        @engine        = _route_engine
        @index_route   = guess_index_route
        @new_route     = guess_new_route
        @show_route    = guess_show_route
        @edit_route    = guess_edit_route
      end

      def successful_response(section, msg = nil)
        @_msg = msg

        respond_to do |f|
          if _override_views.include? section.to_sym
            f.js
            f.html
          else
            flash[:success] = msg

            path = Rails.application.routes.url_helpers.send(@index_route)
            # TODO: We really need to put setup routed on top of this method
            f.js { render "faalis/dashboard/resource/#{section}" }
            f.html { redirect_to path }
          end
        end
      end

      def errorful_resopnse(section, msg = nil)
        @_msg = msg

        respond_to do |f|
          if _override_views.include? section.to_sym
            f.js { render :errors }
            f.html { render :errors }
          else
            flash[:error] = msg
            path = Rails.application.routes.url_helpers.send(@index_route)
            # TODO: We really need to put setup routed on top of this method

            f.js { render 'faalis/shared/errors' }
            f.html { redirect_to path }
          end
        end
      end

      # TODO: Move this method to a suitable place
      def symbolify_keys(hash)
        hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
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
