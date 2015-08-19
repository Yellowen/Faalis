require_dependency 'faalis/dashboard/dsl/form_fields_properties'
require_dependency 'faalis/dashboard/dsl/resource'
require_dependency 'faalis/dashboard/dsl/resources_index'
require_dependency 'faalis/dashboard/dsl/resource_create'
require_dependency 'faalis/dashboard/dsl/resource_show'
require_dependency 'faalis/dashboard/dsl/resource_destroy'
require_dependency 'faalis/dashboard/dsl/sidebar'

module Faalis::Dashboard
  module DSL
    extend ActiveSupport::Concern

    include Faalis::Dashboard::DSL::Resource
    include Faalis::Dashboard::DSL::ResourcesIndex
    include Faalis::Dashboard::DSL::ResourceCreate
    include Faalis::Dashboard::DSL::ResourceShow
    include Faalis::Dashboard::DSL::ResourceDestroy
    include Faalis::Dashboard::DSL::Sidebar

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
