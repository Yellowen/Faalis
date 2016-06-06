require_dependency 'faalis/dashboard/dsl/form_fields_properties'
require_dependency 'faalis/dashboard/sections/resource'
require_dependency 'faalis/dashboard/sections/resources_index'
require_dependency 'faalis/dashboard/sections/resource_create'
require_dependency 'faalis/dashboard/sections/resource_show'
require_dependency 'faalis/dashboard/sections/resource_destroy'
require_dependency 'faalis/dashboard/sections/sidebar'

module Faalis::Dashboard
  module DSL

    extend ActiveSupport::Concern

    include Faalis::Dashboard::Sections::Resource
    include Faalis::Dashboard::Sections::ResourcesIndex
    include Faalis::Dashboard::Sections::ResourceCreate
    include Faalis::Dashboard::Sections::ResourceShow
    include Faalis::Dashboard::Sections::ResourceDestroy
    include Faalis::Dashboard::Sections::Sidebar

    attr_accessor :_override_views

    def _override_views
      @_override_views ||= []
    end

    module ClassMethods
      # override the default view for given views or the result
      # of the given block, by the one from the application
      def override_views(*views, &block)

        define_method(:_override_views) do
          result = views || []
          result.concat(block.call) if block_given?
          result
        end

      end
    end
  end
end
