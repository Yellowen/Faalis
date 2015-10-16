require 'set'

module Faalis::Dashboard::DSL
  class Base
    attr_reader(:action_buttons, :fields, :model, :default_scope,
                :action_buttons)

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
      @action_buttons = []
      @model          = model
      @fields         = resolve_model_reflections
      @fields_type    = {}
    end

    # Allow user to specify an array of model attributes to be used
    # in respected section. For example attributes to show as header
    # columns in index section
    def attributes(*fields_name, **options, &block)
      if options.include? :except
        @fields = resolve_model_reflections.reject do |field|
          options[:except].include? field.to_sym
        end
      else

        # Check for valid field names
        fields_name.each do |name|
          unless @fields.include? name.to_s
            raise ArgumentError, "can't find '#{name}' field for model '#{model}'."
          end
        end
        # set new value for fields
        @fields = fields_name.map(&:to_s) unless fields_name.empty?
      end

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
    #
    #    # or ...
    #
    #    scope :my_scope
    #  end
    #
    #  private
    #    def my_scope
    #      YourModel.where(...)
    #
    #    end
    #
    # Arguments:
    # * **params**: Is the same params passed to controller action.
    def scope(name = nil, &block)
      return @default_scope = block if block_given?
      @default_scope = name.to_sym
    end

    # Define a new action on the `action` place of the current section
    # **options**: Is a hash which contains the action button properties.
    #
    # `label`: Label to use with the button.
    # `href`: The link href to use in the `a` tag
    # `class`:  classes of the button.
    # `icon_class`: font awesome icon to use in button.
    def action_button(**options)
      @action_buttons ||= []
      @action_buttons << options
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
