module Faalis
  module Liquid
    class Tag < ::Liquid::Tag

      attr_reader :arguments, :params

      # This method produce the `tag_name` DSL which is mandatory for
      # each tag and defines the tag name that the tag class should be
      # registered with
      def self.tag_name(name)
        @@name = name
      end

      def self.name
        @@name
      end

      def self.argument(options)
        raise ArgumentError.new "'name' is mandatory for argument in '#{self.class.name}'" if options[:name].nil?

        @arguments ||= []
        @arguments << options
      end

      def initialize(name, args, options)
        super

        if !arguments.empty? && (args.nil? || args.empty?)
            count = arguments.length
            raise ArgumentError.new "'#{count}' argument(s) is/are needed for '#{self.class.name}' tag."
        end

        @direction   = ::Faalis::I18n.direction(::I18n.locale)

        @args = args.split(',').map do |x|
          x.strip.tr('""', '').tr("''", '')
        end

        @params = {}

        arguments.each_with_index do |arg, index|
          @params[arg[:name]] = @args.fetch(index, arg[:default])
        end
      end

      def arguments
        @arguments ||= []
      end
    end
  end
end
