require 'i18n'
require 'devise'
require 'model_discovery'
require 'pundit'
require 'slim-rails'
require 'formtastic'
require 'kaminari'

# Faalis Module
module Faalis
  autoload :Routes,       'faalis/routes'
  autoload :RouteHelpers, 'faalis/routes'

  # TODO: Move to different gem
  autoload :Liquid,       'faalis/liquid'
  #  autoload :Engine,       'faalis/engine'

  autoload :Dashboard,    'faalis/dashboard'
  autoload :Concerns,     'faalis/concerns'
  autoload :ORM,          'faalis/orm'
end

require 'faalis/engine'
require 'faalis/extension'
require 'faalis/i18n'
#require 'faalis/route'
require 'faalis/action_dispatch'
require 'faalis/discovery'
require 'faalis/version'
