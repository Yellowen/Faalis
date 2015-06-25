module Faalis
  module UsersHelper
    def faalisify_url(url)
      puts "00000000000000000000000000"
      dashboard = Faalis::Engine.dashboard_namespace
      return url.gsub("/#{dashboard}/", "/#{dashboard}#/")
    end
  end
end
