require_dependency "red_base/application_controller"

module RedBase
  class HomeController < ApplicationController
    include RedBase::Dashboard::Module

    name = "home"
#    priority 100

#    show_me_on :header

    def index
    end

    def content_for_header
      render "homelink"
    end
  end
end
