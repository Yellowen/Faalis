module Faalis::Dashboard
  module ResourceDSL

    extend ActiveSupport::Concern

    def _resource_title
      _(controller_name.humanize)
    end
  end
end
