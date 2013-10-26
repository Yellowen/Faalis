module RedBase
  module ApplicationHelper


    def dashboard_content_for(section, content = nil, options = {}, &block)
      content = RedBase::Dashboard.instance.content_for(section.to_sym)
      content_for(section, content)
    end

  end
end
