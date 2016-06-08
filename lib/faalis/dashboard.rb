#require_dependency 'faalis/dashboard/dsl'

module Faalis::Dashboard
  autoload :DSL, 'faalis/dashboard/dsl'

  module Helpers
  end

  autoload :Models,   'faalis/dashboard/models'
  autoload :Sections, 'faalis/dashboard/sections.rb'
end
