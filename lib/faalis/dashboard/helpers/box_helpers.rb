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

      def box(title = nil, **options)
        content = Box.new

        yield content

        result = "<div class='box #{options[:box_class] || 'box-default'}'>" +
          "<div class='box-header with-border'>" +
          "<h3 class='box-title'>" +
          title +
          "</h3>"

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
    end
  end
end
