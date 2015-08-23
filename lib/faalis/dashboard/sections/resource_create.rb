module Faalis::Dashboard::DSL
  module ResourceCreate

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def new
      authorize model
      setup_named_routes

      collect_model_fields_for_form

      @resource           = model.new
      @resource_title     = _resource_title.singularize
      @_fields_properties = _form_fields
      @_fields_properties.fields = all_valid_columns_for_form

      return if _override_views.include? :new
      render 'faalis/dashboard/resource/new'
    end

    def edit
      # TODO: Handle nested resource in here
      @resource = model.find(params[:id])
      authorize @resource

      setup_named_routes
      collect_model_fields_for_form

      @resource_title = _resource_title.singularize
      @_fields_properties = _form_fields
      @_fields_properties.fields = all_valid_columns_for_form

      return if _override_views.include? :edit
      render 'faalis/dashboard/resource/edit'
    end

    def update
      # TODO: Handle nested resource in here
      @resource = model.find(params[:id])
      authorize @resource

      setup_named_routes
      new_params = creation_params
      new_params.merge(reflections_hash) if reflections_hash

      # TODO: Move this method to a suitable place instead of controller
      #       itself
      new_params = symbolify_keys(new_params)

      @resource.assign_attributes(**new_params)

      if @resource.save
        successful_response(:update)
      else
        errorful_resopnse(:update)
      end
    end

    # The actual action method for creating new resource.
    def create
      authorize model
      setup_named_routes

      @resource = model.new(creation_params)
      @resource.assign_attributes(**reflections_hash) if reflections_hash

      if @resource.save
        successful_response(:create)
      else
        errorful_resopnse(:create)
      end
    end

    protected

      def collect_model_fields_for_form
        @_fields ||= {}
        valid_columns = all_valid_columns_for_form

        _new_form_fields.each do |name|
          if valid_columns.keys.include? name.to_s
            @_fields[name.to_sym] = valid_columns[name.to_s]
          else
            raise ArgumentError, "can't find '#{name}' field."
          end
        end
      end

      def reflections_hash
        # TODO: cach the result using and instance_var or something
        reflections = model.reflections
        result      = {}

        reflections.each do |name, column|
          value = creation_params[column.foreign_key]
          result[column.foreign_key.to_sym] = value
        end

        return result unless result.empty?
        nil
      end

      def creation_params
        resource = model_name.underscore.to_sym

        # TODO: replace this line with a better solution to not
        #       allowing the blacklisted fields like id, created_at and ...
        fields   = model.columns_hash.keys.map(&:to_sym)
        params.require(resource).permit(*fields)
      end

    private

      def _form_fields
        form = ::Faalis::Dashboard::FormFieldsProperties.new
        form.fields = all_valid_columns_for_form
        form
      end

      def all_valid_columns_for_form
        return @all_valid_columns_for_form unless @all_valid_columns_for_form.nil?
        columns   = model.columns_hash.dup
        relations = model.reflections

        relations.keys.each do |name|
          has_many = ActiveRecord::Reflection::HasManyReflection

          unless relations[name].is_a? has_many
            col    = relations[name]
            column = columns.delete col.foreign_key
            columns[name] = column
          end
        end

        columns.delete('id')
        columns.delete('created_at')
        columns.delete('updated_at')

        @all_valid_columns_for_form = columns
      end

      def _new_form_fields
        all_valid_columns_for_form.keys.map(&:to_sym)
      end

    # The actual DSL for index ages
    module ClassMethods
      # User can provides the fields that he/she wants to be shown
      # in the form for resource creation page.
      # for example:
      #
      # class Dashboard::PostsController < Dashboard::ApplicationController
      #   new_form_fields :title, created_at
      # end
      def new_form_fields(*fields, **options)
        define_method(:_new_form_fields) do
          fields.map(&:to_sym)
        end

        private :_new_form_fields
      end

      def form_fields
        form = ::Faalis::Dashboard::FormFieldsProperties.new
        yield form

        define_method(:_form_fields) do
          form
        end

        private :_form_fields
      end
    end
  end
end
