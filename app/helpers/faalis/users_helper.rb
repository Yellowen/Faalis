module Faalis
  module UsersHelper
    def faalisify_url(url)
      dashboard = Faalis::Engine.dashboard_namespace
      return url.gsub("/#{dashboard}/", "/#{dashboard}#/")
    end
  end
end
