require_dependency "red_base/api_controller"

module Faalis
  class API::V1::LogsController < APIController

    # GET /api/v1/logs
    def index
      @data = File.open("#{Rails.root}/log/#{Rails.env}.log").read(4096)
      respond_with(@data)
    end
  end
end
