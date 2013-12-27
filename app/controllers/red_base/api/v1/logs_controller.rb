require_dependency "red_base/api_controller"

module RedBase
  class API::V1::LogsController < APIController

    # GET /api/v1/logs
    def index
      @data = File.open("#{Rails.root}/log/#{Rails.env}.log").read(4096)
      @data.gsub!(/\n/, "<br/>")
      respond_with(@data)
    end
  end
end
