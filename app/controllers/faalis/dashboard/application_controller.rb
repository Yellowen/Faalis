require 'ostruct'

module Faalis::Dashboard
  class ApplicationController < Dashboard::ApplicationController
    before_action :setup_sidebar
    before_action :setup_header

    private

      def setup_sidebar
        sidebar = {
          t(:authentication) => {
            t(:users) => dashboard_auth_users,
            t(:groups) => dashboard_auth_groups,
          }
        }

        @sidebar = OpenStruct.new(**sidebar)
      end

      def setup_header
      end
  end
end
