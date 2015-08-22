module Faalis::Dashboard::DSL
  class Base
    attr_reader :action_buttons
    attr_reader :fields

    # Define a new action button to be added to the
    # action_buttons list on the corresponding view.
    def action_button(name, **options, &block)
      button = { name: name }
      button.merge! options
      button.merge!(block.call) if block_given?
      @action_buttons[name] = button
    end

    def attributes(*field_names, **options, &block)

    end
  end
end
