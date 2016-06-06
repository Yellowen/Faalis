module Faalis::Dashboard::Sections
  # This module contains several helpers method which would
  # be useful for the rest of faalis dashboard operation.
  module Resource

    extend ActiveSupport::Concern

    included do |base|
      base.before_action :setup_named_routes
    end

    def _resource_title
      controller_name.humanize
    end

    protected

    def _resources
      instance_variable_get("@{plural_name")
    end

    def plural_name
      controller_name.underscore
    end

    def model_name
      "::#{controller_path.gsub('dashboard/', '').classify}"
    end

    def model
      model_name.constantize
    rescue
      msg = "Can't find model '#{model_name}'. Please override 'model' method in your dashboard controller."
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
        engine = "#{namespace.split('/')[0]}::Engine".classify
        if Object.const_defined? engine
          engine.constantize
        else
          logger.info 'You are using locale modules please define route_engine in your controller'
          Rails.application
        end
      end
    end

    # Return the array of action buttons in given `property_object`.
    # `property_object` is an instance of once of DSL classes.
    def action_buttons(property_object)
      @_action_buttons = property_object.action_buttons || []
    end

    def _engine
      nil
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
      scope_ = "#{scope_}#{namespace}_" if !namespace.blank? && _engine.nil?

      name   = controller_name
      if name.singularize == name.pluralize
        "#{scope_}#{name}_index_path"
      else
        "#{scope_}#{name}_path"
      end
    end

    def guess_show_route(scope  = 'dashboard')
      scope_        = "#{scope}_"
      scope_ = "#{scope_}#{namespace}_" if !namespace.blank? && _engine.nil?

      resource_name = controller_name.singularize.underscore
      "#{scope_}#{resource_name}_path".gsub('/', '_')
    end

    def guess_edit_route(scope  = 'dashboard')
      scope_        = "#{scope}_"
      scope_ = "#{scope_}#{namespace}_" if !namespace.blank? && _engine.nil?

      resource_name = controller_name.singularize.underscore
      "edit_#{scope_}#{resource_name}_path".gsub('/', '_')
    end

    def guess_new_route(scope  = 'dashboard')
      scope_        = "#{scope}_"
      scope_ = "#{scope_}#{namespace}_" if !namespace.blank? && _engine.nil?

      resource_name = controller_name.singularize.underscore
      "new_#{scope_}#{resource_name}_path".gsub('/', '_')
    end

    def guess_edit_route(scope  = 'dashboard')
      scope_        = "#{scope}_"
      scope_ = "#{scope_}#{namespace}_" if !namespace.blank? && _engine.nil?

      resource_name = controller_name.singularize.underscore
      "edit_#{scope_}#{resource_name}_path".gsub('/', '_')
    end

    def setup_named_routes
      @engine        = _engine || _route_engine
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
          # Engine to fetch the route from
          engine = _engine || Rails.application
          path   = engine.routes.url_helpers.send(@index_route)
          # TODO: We really need to put setup routed on top of this method
          f.js { render "faalis/dashboard/resource/#{section}" }
          f.html { redirect_to path }
        end
      end
    end

    def errorful_resopnse(section, msg = nil, &block)
      @_msg = msg

      respond_to do |f|
        if _override_views.include? section.to_sym
          f.js { render :errors }
          f.html { render :errors }
        else
          flash[:error] = msg

          # Engine to fetch the route from
          engine = _engine || Rails.application
          path   = engine.routes.url_helpers.send(@index_route)
          # TODO: We really need to put setup routed on top of this method

          f.js { render 'faalis/dashboard/shared/errors' }
          if block_given?
            f.html(&block)
          else
            f.html { redirect_to path }
          end
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
      def route_engine(name = nil, &block)
        define_method(:_route_engine) do
          return block.call if block_given?
          return name unless name.nil?
          fail 'You have to provide a name or a block'
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

      # Set the engine name of current controller. It's necessary to provide and
      # engine name if the controller belongs to an engine other than Faalis or
      # Rails.application.
      def engine(name)
        define_method(:_engine) do
          name.constantize
        end
      end

      # Specify the model name of controller. This method overrides the
      # `model_class` **class method** and `model_name` instance method.
      def model_name(name)
        define_singleton_method :model_class do
          name.constantize
        end

        define_method :model_name do
          name
        end
      end

      # Returns the actual model class by looking at `controller_name` and
      # and `controller_path`. If user uses the `model_name` **class method**
      # (the `model_name` DSL) then this method will override by the
      # `model_name` defination of `model_class`
      def model_class
        name  = controller_name
        path  = controller_path.gsub(name, '').gsub(/dashboard\//, '')

        "#{path}#{name}".classify.constantize
      end
    end

  end
end
