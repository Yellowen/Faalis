module Faalis
  module DashboardHelper

    def localized_time(time)
      # Fixme: Setup and use Rails l10n
      time.strftime("%Y-%m-%d %H:%M")
    end

    def action_buttons(buttons)
      buttons_html = ''

      buttons.each do |button|
        href   = button.fetch(:href, '#')
        klass  = button.fetch(:class, 'btn-success')
        remote = button.fetch(:remote, true).to_s
        icons  = button.fetch(:icon_class, "")
        label  = button.fetch(:label, '')
        model  = button.fetch(:model, nil)

        buttons_html += "<a class='action-button btn pull-right btn-sm " +
                        "#{klass}' href='#{href}' data-remote='#{remote}'>\n" +
                        "<i class='fa fa-#{icons}'></i>" +
                        label +
                        '</a>'

      end
      buttons_html.html_safe
    end

    # Translate route name to url dynamically
    def get_url(route_name, id = nil, engine = Rails.application)
      return engine.routes.url_helpers.send(route_name, id.to_s) unless id.nil?
      engine.routes.url_helpers.send(route_name)
    end

    def draw_menu(menu)
      klass = menu.class || ''
      klass += 'treeview' if sidebar.children?
      href  = menu.url || '#'

      result = "<li class='#{klass}'> \
            <a href='#{href}'> \
              <i class='#{menu.icon}'></i>
              <span>#{menu.title}</span>
              <span class='label label-primary pull-right'>4</span>
            </a>"

      if sidebar.respond_to? :children
        result += "<ul class='treeview-menu slide'>"
        sidebar.children.each do |submenu|
          result += "<li>\
                      <a href='#{submenu.url}'>
                        <i class='#{submenu.icon}'></i>
                        #{submenu.title}
                      </a>"
          result += draw_menu submenu
          result += '</li>'
        end
        result += '</ul>'
      end
    end
  end
end
