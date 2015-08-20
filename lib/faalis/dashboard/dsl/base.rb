module Faalis::Dashboard::DSL
  class Base
    attr_reader :action_buttons

    def action_button(:name, **options, &block)
    end
  end
end
