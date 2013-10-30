require_dependency "red_base/application_controller"

module RedBase
  class DashboardController < ApplicationController

    include RedBase::Dashboard::Controller

    layout "red_base/dashboard"
    before_filter :authenticate_user!

    respond_to :json, :html


    def index
    end

    def modules
      dashboard_modules = []

      RedBase::Engine.dashboard_modules.each do |module_name, attrs|
        if not attrs.include? :title
          attrs[:title] = _(module_name.to_s)
        end

        if not attrs.include? :resource
          attrs[:resource] = module_name.to_s
        end

        dashboard_modules << attrs
      end
      dashboard_modules = {:modules => dashboard_modules}
      respond_with dashboard_modules
    end
  end
end
