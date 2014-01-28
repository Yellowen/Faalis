require_dependency "faalis/application_controller"

module Faalis
  class DashboardController < ApplicationController

    include Faalis::Dashboard::Controller

    layout "faalis/dashboard"
    before_filter :authenticate_user!, :only => [:modules, :index]

    respond_to :json, :html

    def jstemplate
      if user_signed_in?
        render :template => "angularjs_templates/#{params[:path]}", :layout => nil
      else
        render :login_required_page
      end
    end

    def index
      @jstemplates_path = "/templates"
    end

    def modules
      dashboard_modules = []

      Faalis::Engine.dashboard_modules.each do |module_name, attrs|
        if not attrs.include? :title
          attrs[:title] = _(module_name.to_s)
        end

        if not attrs.include? :resource
          attrs[:resource] = module_name.to_s
        end

        #if not attrs.include? :model
        #  attrs[:model] = attrs[:resource].camelize.constantize
        #end

        dashboard_modules << attrs
      end
      dashboard_modules = {:modules => dashboard_modules}
      respond_with dashboard_modules
    end
  end

end
