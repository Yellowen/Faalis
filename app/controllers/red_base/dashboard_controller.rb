require_dependency "red_base/application_controller"

module RedBase
  class DashboardController < ApplicationController

    include RedBase::Dashboard::Controller

    layout "red_base/dashboard"
    before_filter :authenticate_user!

    dashboard_modules ["RedBase::HomeController"]

    def index
    end

  end
end
