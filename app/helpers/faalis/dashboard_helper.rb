module Faalis
  module DashboardHelper

    def localized_time(time)
      # Fixme: Setup and use Rails l10n
      time.strftime("%Y-%m-%d %H:%M")
    end

    def get_url(route_name, id = nil, engine = Rails.application)
      return engine.routes.url_helpers.send(route_name, id.to_s) unless id.nil?
      engine.routes.url_helpers.send(route_name)
    end
  end
end
