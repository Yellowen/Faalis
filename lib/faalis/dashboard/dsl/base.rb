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
    def initialize(model)
      @action_buttons = {}
      @model          = model
      @fields         = resolve_model_reflections
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
      @fields = fields_name unless fields_name.empty?
      @fields.concat(block.call) if block_given?
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
    def scope(params)
      return yield params if block_given?
      model.page(params[:page])
    end

  private

    # Replace foreign key names with their reflection names
    # and create an array of model fields
    def resolve_model_reflections
      # TODO: cach the result using and instance_var or something
      reflections = model.reflections
      columns = model.column_names

      reflections.each do |name, column|
        if columns.include? column.foreign_key.to_s
          index          = columns.index(column.foreign_key)
          columns[index] = name.to_s
        end
      end
      columns
    end
  end
end
