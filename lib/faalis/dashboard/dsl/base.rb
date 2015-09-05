require 'set'

module Faalis::Dashboard::DSL
  class Base
    attr_reader :action_buttons, :fields, :model

    # Base class for all the DSL property classes to be
    # used as the yielded object inside each section DSL
    # scope.
    #
    # For example the below code will yield an instance of
    # one of this class children.
    #
    #  in_index do
    #    # This will yield an instance of this class child
    #  end
    #
    # The most important note in this class is that all the public
    # methods that their name starts with an underscore (_) not meant to
    # be used as DSL.
    def initialize(model)
      @action_buttons = {}
      @model          = model
      @fields         = resolve_model_reflections
      @fields_type    = {}
    end

    # Define a new action button to be added to the
    # action_buttons list on the corresponding view.
    def action_button(name, **options, &block)
      button = { name: name }
      button.merge! options
      button.merge!(block.call) if block_given?
      @action_buttons[name] = button
    end

    # Allow user to specify an array of model attributes to be used
    # in respected section. For example attributes to show as header
    # columns in index section
    def attributes(*fields_name, **options, &block)
      # TODO: use options parameter to implement an except feature

      fields_name.each do |name|
        unless @fields.include? name.to_s
          raise ArgumentError, "can't find '#{name}' field for model '#{model}'."
        end
      end

      @fields = fields_name.map(&:to_s) unless fields_name.empty?
      @fields.concat(block.call.map(&:to_s)) if block_given?
    end

    # Return the default scope for current properties object.
    # scope will be used to fetch all the records for the given
    # section. The Default implementation belongs to index section
    # and return a page aware list of all the objects.
    #
    # You can easily change it via the corresponding section dsl.
    # For example in case of `index` section:
    #
    #  in_index do
    #    scope do |params|
    #      YourModel.all
    #    end
    #  end
    #
    # Arguments:
    # * **params**: Is the same params passed to controller action.
    def scope(&block)
      @_default_scope = block
    end

    def default_scope(params)
      return @_default_scope.call(params) if defined? @_default_scope
      model.page(params[:page])
    end

  private

    # Replace foreign key names with their reflection names
    # and create an array of model fields
    def resolve_model_reflections
      # TODO: cach the result using and instance_var or something
      reflections = model.reflections
      columns     = Set.new model.column_names
      new_fields  = Set.new
      fields_to_remove = Set.new

      reflections.each do |name, column|
        has_many = ActiveRecord::Reflection::HasManyReflection
        has_and_belongs_to_many = ActiveRecord::Reflection::HasAndBelongsToManyReflection

        if !column.is_a?(has_many) && !column.is_a?(has_and_belongs_to_many)
          new_fields << name.to_s
          fields_to_remove << column.foreign_key.to_s
        end
      end

      if model.respond_to? :attachment_definitions
        # Paperclip is installed and model contains attachments
        model.attachment_definitions.each do |name, _|
          new_fields << name.to_s
          ["file_name", "content_type", "file_size", "updated_at"].each do |x|
            fields_to_remove << "#{name}_#{x}"
          end
        end
      end

      columns.union(new_fields) - fields_to_remove
    end
  end
end
