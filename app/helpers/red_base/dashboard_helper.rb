module RedBase
  module DashboardHelper

    def content_for(section, content = nil, options = {}, &block)
      content = RedBase::Dashboard.instance.content_for(section.to_sym)
      super(section, content)
    end

  end
end
