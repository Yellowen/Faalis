module Faalis::Dashboard
  module DestroyDSL

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def destroy
      @resource = model.find(params[:id])
      authorize model
      setup_named_routes
      @resource_title = _resource_title.singularize
      @resource.destroy

      return if _override_views.include? :destroy
      render 'faalis/dashboard/resource/destroy'
    end
  end
end
