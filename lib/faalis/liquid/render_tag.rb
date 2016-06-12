module Faalis
  module Liquid
    # In order to use this class make sure to override the `before_render`
    # and implement you logic there, Don't bother to override the `render`
    # method
    class RenderTag < Tag

      class << self
        def template(value)
          @@_template = value
        end
      end

      def before_render(context)
        raise NotImplemented.new 'You must override `before_render` method.'
      end

      def render(context)
        before_render(context)
        render_template(context)
      end

      class NotImplemented < Exception; end

      private

      def render_template(context)

        controller = context.registers[:controller]
        view_paths = controller.view_paths
        request    = context.registers[:view].request
        controller = controller.class

        controller.view_paths = view_paths

        patched_request = assignments.merge(request.env)
        renderer = controller.renderer.new(patched_request)

        renderer.render @@_template, layout: nil
      end

      def assignments
        tmp = instance_variable_names.map do |x|
          [x[1..-1], instance_variable_get(x)]
        end

        { assigns: Hash[tmp] }
      end
    end
  end
end
