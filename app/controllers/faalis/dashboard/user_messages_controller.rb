module Faalis::Dashboard
  class UserMessagesController < ::Dashboard::ApplicationController

    engine 'Faalis::Engine'

    override_views :show, :new

    def sent
      authorize model

      fetch_and_set_all
      action_buttons(index_properties)

      @_tools_buttons = index_properties.tool_buttons || {}
      @resources = @resources.where(sender: current_user)

      return if _override_views.include? :index
      render 'faalis/dashboard/resource/index'
    end

    private

    def index_hook(resource)
      resource = resource.where(reciver: current_user)
    end
  end
end
