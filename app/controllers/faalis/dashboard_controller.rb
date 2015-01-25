require_dependency 'faalis/application_controller'


module Faalis
  class DashboardController < ApplicationController

    include Faalis::Dashboard::Controller

    layout 'faalis/dashboard'
    before_filter :authenticate_user!, :only => [:modules, :index]

    respond_to :json, :html

    def jstemplate
      if user_signed_in?
        render template: "angular/#{params[:path]}", layout: nil
      else
        render :login_required_page
      end
    end

    def index
      redirect_to dashboard_path if params.include? :signin
      @jstemplates_path = '/templates'
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

        # If class did not given by user in settings
        # Faalis tries to guess the class name
        if not attrs.include? :model
          begin
            klass = attrs[:resource].camelize.constantize

            if klass.respond_to? :possible_permissions
              attrs[:model] = attrs[:resource].camelize
            else
              attrs[:model] = ""
            end

          rescue NameError
            attrs[:model] = ""
          end
        end

        dashboard_modules << attrs
      end
      dashboard_modules = {:modules => dashboard_modules}
      respond_with dashboard_modules
    end
  end

end
