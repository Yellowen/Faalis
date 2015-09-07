require_dependency 'faalis/dashboard/dsl/base'

module Faalis::Dashboard::DSL
  class Index < Base

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

    alias_method :table_fields, :attributes
  end
end
