module Faalis
  module Generators
    class Relation < String
      attr_accessor :to

      def initialize(value, to, options = "")
        super(value)
        @options = options
        @to = to
      end

      def resource_name
        to.split("/").last
      end

      def to
        result = "'"
        if options.include? "parents"
          field_parents.each do |parent|
            result = "#{result}/#{parent}/' + $scope.#{parent}_id + '"
          end
          result = "#{result}/"
        end
        "#{result}#{@to}'"
      end

      def options
        unless @options.empty?
          Hash[@options.split(',').map {|pair| pair.strip.split(':').map(&:strip) }]
        else
          {}
        end
      end

      def field_parents
        if options.include? "parents"
          options["parents"].split(";")
        else
          []
        end
      end

      def restangular
        result = "API"
        if options.include? "parents"
          field_parents.each do |parent|
            result = "#{result}.one('#{parent}', #{}_id)"
          end
        end
        to.split("/").each do |resource|
          result = "#{result}.all(\"#{resource}\")"
        end
        result
      end

      def get_list
        "#{restangular}.getList()"
      end
    end
  end
end
