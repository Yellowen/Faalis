require 'ostruct'

module Faalis
  module Dashboard
    class ApplicationController < Faalis::ApplicationController
      layout 'faalis/dashboard'

      before_action :setup_sidebar
      before_action :setup_header

      private

        def setup_sidebar

          user = OpenStruct.new(title: _('Users'),
                                url: dashboard_auth_users_path)

          group = OpenStruct.new(title: _('Groups'),
                                 url: dashboard_auth_groups_path)

          auth = OpenStruct.new(icon: 'fa fa-group',
                                title: _('Authentication'),
                                children: [user, group])

          @sidebar = OpenStruct.new(menu_entries: [auth])
        end

        def setup_header
          @dashboard_section_title = _(controller_name).humanize
          @dashboard_section_slug  = _(action_name).humanize
        end
    end
  end
end
