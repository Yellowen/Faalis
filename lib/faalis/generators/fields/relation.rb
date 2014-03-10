module Faalis
  module Generators
    class Relation < String
      attr_accessor :to

      def initialize(value, to, :options => "")
        super(value)
        pattern = /(?<key>[^,:]+):(?<value>[^,:]+)/i
        unless options.empty?
          matched = pattern.match(options)
          if matched
          end
        end
        self.to = to
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
