module Faalis::Dashboard
  module NewDSL

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def new
      authorize model
      setup_named_routes

      collect_model_fields

      @resource           = model.new
      @resource_title     = _resource_title.singularize
      @_fields_properties = _form_fields
      @_fields_properties.fields = all_valid_columns

      return if _override_views.include? :new
      render 'faalis/dashboard/resource/new'
    end

    def create
      authorize model
      @resource = model.new(creation_params)

      if @resource.save
        successful_response(:create)
      else
        errorful_resopnse(:create)
      end
    end

    protected

      def collect_model_fields
        @_fields ||= {}
        valid_columns = all_valid_columns

        _new_form_fields.each do |name|
          if valid_columns.keys.include? name.to_s
            @_fields[name.to_sym] = valid_columns[name.to_s]
          else
            raise ArgumentError, "can't find '#{name}' field."
          end
        end
      end

      def creation_params
        resource = model_name.underscore.to_sym
        fields = all_valid_columns.map(&:to_sym)
        params.require(resource).permit(fields)
      end

    private

      def _form_fields
        form = ::Faalis::Dashboard::FormFieldsProperties.new
        form.fields = all_valid_columns
        form
      end

      def all_valid_columns
        return @all_valid_columns unless @all_valid_columns.nil?
        columns   = model.columns_hash.dup
        relations = model.reflections

        relations.keys.each do |name|
          col    = relations[name]
          column = columns.delete col.foreign_key
          columns[name] = column || 66
        end

        columns.delete('id')
        columns.delete('created_at')
        columns.delete('updated_at')

        @all_valid_columns = columns
      end

      def _new_form_fields
        all_valid_columns.keys.map(&:to_sym)
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
