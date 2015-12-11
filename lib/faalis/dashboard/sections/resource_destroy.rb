module Faalis::Dashboard::Sections
  module ResourceDestroy

    extend ActiveSupport::Concern

    # The actual action method of a dashboard controller
    def destroy
      @resource = model.find(params[:id])
      authorize @resource

      @resource_title = _resource_title.singularize

      before_destroy_hook(@resource)
      @resource.destroy

      return if _override_views.include? :destroy
      render 'faalis/dashboard/resource/destroy'
    end

    private

      # You can override this method to change the behaviour of `destroy`
      # action
      def before_destroy_hook(resource)
      end
  end
end
