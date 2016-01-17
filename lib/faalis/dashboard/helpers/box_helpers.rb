module Faalis::Dashboard
  module Helpers
    module BoxHelpers

      class Box
        def footer(&block)
          return @footer = nil unless block_given?
          @footer = block
        end

        def body(&block)
          @body = block
        end

        def footer_content
          @footer
        end

        def body_content
          @body
        end
      end

      class Tabs

        class Tab
          attr_reader :title, :title_icon
          attr_accessor :content, :id

          def initialize(title, **options)
            @title      = title
            @active     = false
            @active     = true if options[:active] == true
            @title_icon = options[:title_icon]
          end

          def active?
            @active
          end
        end

        attr_reader :title_icon

        def initialize(**options)
          @tabs       = []
          @title_icon = options[:title_icon]
        end


        def tab(title, **options, &block)
          id  = @tabs.length
          tab = Tab.new(title, **options)
          tab.content = block
          tab.id = id
          @tabs << tab
        end

        def tabs
          @tabs
        end
      end

      def box(title = nil, **options)
        content = Box.new

        yield content

        result = "<div class='box #{options[:box_class] || 'box-default'}'>" +
          "<div class='box-header with-border'>" +
          "<h3 class='box-title'>" +
          title +
          '</h3>'

        unless options[:show_tools].nil?
          result += "<div class='box-tools pull-right'>" +
            "<button class='btn btn-box-tool' data-widget='collapse'>" +
            "<i class='fa fa-minus'></i></button>" +
            "</div><!-- /.box-tools -->"
        end

        result += "</div><!-- /.box-header -->" +
          "<div class='box-body'>" +
          capture(&content.body_content) +
          "</div><!-- /.box-body -->"

        unless content.footer_content.nil?
          result += '<div class="box-footer">' +
            content.footer_content +
            "</div><!-- /.box-footer-->"
        end

        result += "</div><!-- /.box -->"

        result.html_safe
      end


      def tabbed_box(title = nil, **options)
        content = Tabs.new

        yield content

        result = "<div class='nav-tabs-custom'>" +
          "<ul class='nav nav-tabs pull-right'>"

        content.tabs.each do |tab|
          active = nil
          active = "class='active'" if tab.active?

          result += "<li #{active}><a href='#tab_#{tab.id}-#{tab.id}' data-toggle='tab'>" +
            "<i class='fa #{tab.title_icon}'></i> #{tab.title}</a></li>"
        end

        result += "<li class='pull-left header'><i class='fa #{options[:title_icon]}'></i>#{title}</li>" +
          "</ul>" +
          "<div class='tab-content'>"

        content.tabs.each do |tab|
          result += "<div class='tab-pane #{'active' if tab.active?}' id='tab_#{tab.id}-#{tab.id}'>" +
            capture(&tab.content) +
            "</div><!-- /.tab-pane -->"
        end

        result += "</div><!-- /.tab-content --></div>"
        result.html_safe
      end
    end
  end
end
