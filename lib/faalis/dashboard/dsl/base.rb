module Faalis::Dashboard::DSL
  class Base
    attr_reader :action_buttons
    attr_reader :fields

    # Define a new action button to be added to the
    # action_buttons list on the corresponding view.
    def action_button(name, **options, &block)
      @action_buttons ||= []
      button = { name: name }
      button.merge! options
      button.merge!(block.call) if block_given?
      @action_buttons[name] = button
    end

    # Allow user to specify an array of model attributes to be used
    # in respected section. For example attributes to show as header
    # columns in index section
    def attributes(*fields_name, **options, &block)
      @fields ||= []
      # TODO: use options parameter to implement an except feature
      @fields = fields_name unless fields_name.nil?
      @fields.concat(block.call) if block_given?
    end
  end
end
