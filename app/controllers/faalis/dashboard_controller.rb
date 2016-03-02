require_dependency 'faalis/dashboard/application_controller'


module Faalis
  class DashboardController < ::Dashboard::ApplicationController

    before_action :authenticate_user!, :only => [:modules, :index]

    def index
      redirect_to dashboard_path if params.to_h.include? :signin
    end

    def not_found
    end
  end
end
