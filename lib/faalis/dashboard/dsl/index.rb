require_dependency 'faalis/dashboard/dsl/base'

module Faalis::Dashboard::DSL
  class Index < Base
    attr_reader :tool_buttons

    # Allow user to specify an array of model attributes to be used
    # in respected section. For example attributes to show as header
    # columns in index section
    def attributes(*fields_name, **options, &block)
      if options.include? :except
        @fields = resolve_model_reflections.reject do |field|
          options[:except].include? field.to_sym
        end
      else
        # set new value for fields
        @fields = fields_name.map(&:to_s) unless fields_name.empty?
      end

      @fields.concat(block.call.map(&:to_s)) if block_given?
    end

    # Define a new tool on the `tool` place of the index section
    # **options**: Is a hash which contains the tool button properties.
    #
    # `class`:  classes of the button.
    # `icon_class`: font awesome icon to use in button.
    # `remote`: whether
    #
    # You have to provide a block for this method which returns
    # a string to be used as the **href** for the link
    def tool_button(**options, &block)
      fail 'You have to provide a block for `tool_button`' if !block_given?

      options[:block] = block
      @tool_buttons ||= []
      @tool_buttons << options
    end

    alias_method :table_fields, :attributes
  end
end
