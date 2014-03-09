module Faalis
  module Generators
    class Relation < String
      attr_accessor :to

      def initialize(value, to_)
        super(value)
        patternt = /([^:\{\}]+)(?:\{(.+)\})/
        self.to = to_
      end

      def resource_name
        to.split("/").last
      end

      def restangular
        result = "API"
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
