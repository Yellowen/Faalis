require_dependency "faalis/application_controller"

module Faalis
  class API::V1::WorkflowsController < ::APIController

    def index
      @workflows = Faalis::Workflow.all
      respond_with(@worklows)
    end

  end
end
