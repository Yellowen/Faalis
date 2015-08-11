require_dependency 'faalis/dashboard/index_dsl'

module Faalis::Dashboard
  module DSL
    included do |base|
      attr_accessor :_overrided_views

      @@_include_blocks.each do |block|
        block.call(base)
      end
    end

  end
end
