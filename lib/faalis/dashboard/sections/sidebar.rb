require_dependency 'faalis/dashboard/models/sidebar'

module Faalis::Dashboard::Sections
  module Sidebar

    extend ActiveSupport::Concern

    protected

      def setup_sidebar
        @sidebar = sidebar do |sidebar|
          sidebar.faalis_entries
        end
      end

    private

      def sidebar(name, **options, &block)
        sidebar = Faalis::Dashboard::Models::Sidebar.new(name, **options)

        yield sidebar if block_given?

        sidebar
      end

    module ClassMethods

      def sidebar(name, **options, &block)
        side = Faalis::Dashboard::Models::Sidebar.new(name, **options)

        side.instance_eval do
          block.call if block_given?
        end

        define_method(:setup_sidebar) do
          instance_variable_set('@sidebar', side)
        end
      end
    end
  end
end
