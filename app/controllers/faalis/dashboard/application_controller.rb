require 'ostruct'

module Faalis
  module Dashboard
    class ApplicationController < Faalis::ApplicationController

      include Faalis::Dashboard::DSL

      layout 'faalis/dashboard'

      before_action :authenticate_user!
      before_action :setup_sidebar
      before_action :setup_header

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_404

      protected

        def setup_header
          @dashboard_section_title = t(controller_name.underscore)
          @dashboard_resource_name = t(controller_name.underscore.singularize)
          @dashboard_section_slug  = t(action_name)
        end

      private

        def user_not_authorized
          flash[:alert] = t('faalis.not_authorized')
          redirect_to new_user_session_path
        end

        def redirect_to_404(e)
          logger.warn "Catch and ActiveRecord::RecordNotFoundL: '#{e}'"

          respond_to do |f|
            f.html { redirect_to faalis.dashboard_not_found_url }
            f.js { render 'faalis/dashboard/not_found' }
          end
        end
    end
  end
end
