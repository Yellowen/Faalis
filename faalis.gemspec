$:.push File.expand_path('../lib', __FILE__)

# Maintain Faalis gem's version:
require 'faalis/version'

# Describe Faalis gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'faalis'
  s.version     = Faalis::VERSION
  s.authors     = ['Sameer Rahmani', 'Behnam Ahmad Khan Beigi']
  s.email       = ['lxsameer@gnu.org', 'yottanami@gnu.org']
  s.homepage    = 'http://faalis.io'
  s.summary     = 'Faalis is a ruby on rails engine which provides a platform to easily build a web application'
  s.description = 'Faalis is a ruby on rails engine which provides a platform to easily build a web application. Features like Dashboard, complex code generation and other awesome features. For more information checkout the docs.'
  s.required_ruby_version = '~> 2.0'

  s.licenses = ['GPL-2']
  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile',
                'README.md']

  s.test_files = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.add_dependency 'rails', '~> 4.2', '>= 4.2.0'

  # Authentication
  s.add_dependency 'omniauth'
  s.add_dependency 'devise', '~> 3.5', '>= 3.4.0'
  s.add_dependency 'admin_lte-rails', '~> 2.2.0.7'
  #s.add_dependency 'rails-assets-admin-lte'
  # Authorization
  s.add_dependency 'pundit'
  #s.add_dependency 'mailboxer'

  # API
  s.add_dependency 'jbuilder'

  # Forms
  s.add_dependency 'formtastic'

  # Assets
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'slim-rails'
  s.add_dependency 'sprockets'
  s.add_dependency 'turbolinks'
  s.add_dependency 'jquery-turbolinks'

  # TODO: It should be dependency of
  # dashboard or main template
  s.add_dependency 'modernizr-rails'

  # We have to give up lodash for sugar
  #s.add_dependency 'lodash-rails', '~>2.4'
  s.add_dependency 'rails-assets-sugar', '1.4.1'

  s.add_development_dependency 'execjs'
  s.add_dependency 'fast_gettext'

  # i18n
  s.add_dependency 'gettext'
  s.add_dependency 'ruby_parser'
  s.add_dependency'gettext_i18n_rails'
  s.add_dependency 'colorize'

  # model_discovery
  s.add_dependency 'model_discovery', '~> 0.3.0'

  # To support multiple ORM at once
  s.add_dependency 'orm_adapter'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'generator_spec'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'

  # We need to use next version of did you mean gem
  # for JRuby support. current version: 0.9.5
  #s.add_development_dependency 'did_you_mean'
  s.add_development_dependency 'annotate'
end
