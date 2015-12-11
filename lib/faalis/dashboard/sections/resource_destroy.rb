module Faalis::Dashboard::Sections
  module ResourceDestroy

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def destroy
      @resource = model.find(params[:id])
      authorize @resource

      @resource_title = _resource_title.singularize
      @resource.destroy

      return if _override_views.include? :destroy
      render 'faalis/dashboard/resource/destroy'
    end
  end
end
