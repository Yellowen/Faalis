module Faalis::Dashboard::DSL
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
        @_fields ||= {}
        valid_columns = all_valid_columns_for_show

        _show_fields.each do |name|
          if valid_columns.keys.include? name.to_s
            @_fields[name.to_sym] = valid_columns[name.to_s]
          else
            raise ArgumentError, "can't find '#{name}' field."
          end
        end
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
    end
  end
end
