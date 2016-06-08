module Faalis
  module Liquid
    class Block < ::Liquid::Block

      def self.block_name(name)
        @@name = name
      end

      def self.name
        @@name
      end
    end
  end
end
