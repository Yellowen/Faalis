require 'set'
require_dependency 'faalis/dashboard/dsl/create'

module Faalis::Dashboard::Sections
  module ResourceCreate

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def new
      authorize model
      setup_named_routes

      collect_model_fields_for_form

      @resource           = model.new
      @resource_title     = _resource_title.singularize
      @_fields_properties = form_properties._field_details
      @multipart          = has_attachment?

      return if _override_views.include? :new
      render 'faalis/dashboard/resource/new'
    end

    def edit
      # TODO: Handle nested resource in here
      @resource = model.find(params[:id])
      authorize @resource

      setup_named_routes
      collect_model_fields_for_form

      @resource_title     = _resource_title.singularize
      @_fields_properties = form_properties._field_details
      @multipart          = has_attachment?

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

      @resource.assign_attributes(**reflections_hash) unless reflections_hash.nil?

      # TODO: Handle M2M relations in here

      if @resource.save
        successful_response(:create)
      else
        errorful_resopnse(:create)
      end
    end

    protected

      def collect_model_fields_for_form
        @_fields ||= form_properties.fields_for_form
      end

      def reflections_hash
        # TODO: cach the result using and instance_var or something
        reflections = model.reflections
        result      = {}

        reflections.each do |name, column|
          has_many = ActiveRecord::Reflection::HasManyReflection
          has_and_belongs_to_many = ActiveRecord::Reflection::HasAndBelongsToManyReflection

          if !column.is_a?(has_many) && !column.is_a?(has_and_belongs_to_many)
            value = creation_params[column.foreign_key]
            result[column.foreign_key.to_sym] = value
          end
        end

        return result unless result.empty?
        nil
      end

      def creation_params
        resource = model_name.underscore.to_sym

        # TODO: replace this line with a better solution to not
        #       allowing the blacklisted fields like id, created_at and ...
        fields = model.columns_hash.keys.map(&:to_sym)
        fields.concat(attachment_fields.map(&:to_sym ))
        fields = Set.new(fields).map(&:to_sym)
        params.require(resource).permit(*fields)
      end

    private

      def all_valid_columns_for_form
        return @all_valid_columns_for_form unless @all_valid_columns_for_form.nil?
        columns   = model.columns_hash.dup
        relations = model.reflections

        relations.keys.each do |name|
          has_many = ActiveRecord::Reflection::HasManyReflection
          has_and_belongs_to_many = ActiveRecord::Reflection::HasAndBelongsToManyReflection

          unless relations[name].is_a? has_many
            if relations[name].is_a? has_and_belongs_to_many
              columns[name] = Class.new { def self.type() :multiple_select end }
            else
              col    = relations[name]
              column = columns.delete col.foreign_key
              columns[name] = column
            end
          end
        end

        columns.delete('id')
        columns.delete('created_at')
        columns.delete('updated_at')

        @all_valid_columns_for_form = columns
      end

      def form_properties
        Faalis::Dashboard::DSL::Create.new(model)
      end

      def _new_form_fields
        all_valid_columns_for_form.keys.map(&:to_sym)
      end

    # The actual DSL for index ages
    module ClassMethods

      # To specify any property and action for `form` section both new and edit
      # You must use `in_form` class method with block of properties. For
      # example:
      #
      #   class ExamplesController < Dashboard::Application
      #     in_form do
      #       attributes :name, :description
      #       action_button :close, dashboard_example_close_path
      #     end
      #   end
      def in_form(&block)
        model = controller_name.classify.constantize
        form_props = Faalis::Dashboard::DSL::Create.new(model)

        unless block_given?
          fail ArgumentError, "You have to provide a block for 'in_form'"
        end

        form_props.instance_eval(&block) if block_given?

        define_method(:form_properties) do
          return form_props
        end

        private :form_properties
      end

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
