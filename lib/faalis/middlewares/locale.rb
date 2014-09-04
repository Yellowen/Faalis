module Faalis
  module Middlewares

    # Locale middleware for `Faalis`. This middleware try to set
    # the locale from url.
    class Locale
      def initialize(app)
        @app = app
      end

      def call(env)
        req = Rack::Request.new(env)

        # Check whether locale is presence or not.
        if locale = req.path_info.match(/^([a-z]{2})\/.*/)
          # If its set the default locale to it.
          locale = locale[1]
        else
          # Use pre-defined default if it isn't
          locale = ::I18n.default_locale
        end


        req.params['locale'] ||= locale
        ::I18n.locale = locale
        @app.call env
      end
    end
  end
end
