module Faalis
  class Configuration

    class << self
      attr_accessor :features, :enabled_features

      def enabled_features
        @enabled_features || []
      end

      def features
        [:colorize_output]
      end

      def enable(feature)
        fail "No such feature: '#{feature}'" unless features.include? feature
        features << featue unless enabled_features.include? feature
      end

      def disable
        fail 'TODO: create a disable method'
      end
    end
  end
end
