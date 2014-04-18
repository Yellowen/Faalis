require_dependency "faalis/application_controller"

module Faalis
  class API::V1::WorkflowsController < ::APIController

    def index
      workflows = Faalis::Workflow.all
      @workflows = []

      workflows.map do |workflow_instance|
        @workflows << workflow_instance.name.constantize.new(workflow_instance)
      end

      respond_with(@worklows)
    end

  end
end
