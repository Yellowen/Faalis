require_dependency 'faalis/dashboard/resource_dsl'
require_dependency 'faalis/dashboard/index_dsl'
require_dependency 'faalis/dashboard/new_dsl'

module Faalis::Dashboard
  module DSL
    extend ActiveSupport::Concern

    include Faalis::Dashboard::ResourceDSL
    include Faalis::Dashboard::IndexDSL
    include Faalis::Dashboard::NewDSL

    attr_accessor :_override_views

    def _override_views
      @_override_views ||= []
    end

    module ClassMethods
      # override the default view for given views or the result
      # of the given block, by the one from the application
      def override_views(*views, &block)
        views.concat(block.call) if block_given?
        instance_variable_set('@_overrided_views', views)
      end
    end
  end
end
