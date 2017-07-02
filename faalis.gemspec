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

  s.licenses = ['GPL-2.0']
  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile',
                'README.md']

  s.test_files = Dir['test/**/*']
  s.require_paths = ['lib']

  s.cert_chain  = ['certs/lxsameer.pem']
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  s.add_dependency 'rails', '~> 5.1.0'
  s.add_dependency 'railties'

  # Authentication
  s.add_dependency 'devise', '~>4.3.0'
  s.add_dependency 'admin_lte-rails', '~> 2.3.0'

  # Authorization
  s.add_dependency 'pundit', '~>1.1.0'

  # Forms
  s.add_dependency 'formtastic', '~>3.1.5'

  # TODO: Move this gem to template gems
  s.add_dependency 'formtastic-bootstrap'

  # Assets
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'slim-rails'
  s.add_dependency 'sprockets', '~>3.7.1'
  s.add_dependency 'kaminari'

  # i18n
  s.add_dependency 'i18n'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'colorize'

  # model_discovery
  s.add_dependency 'model_discovery', '~> 0.3.8'

  # To support multiple ORM at once
  s.add_dependency 'orm_adapter'

  s.add_development_dependency 'minitest-rails'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'fabrication'
  s.add_development_dependency 'minitest-rails-capybara'
  s.add_development_dependency 'minitest-around'
  s.add_development_dependency 'guard-minitest'

  # We need to use next version of did you mean gem
  # for JRuby support. current version: 0.9.5
  #s.add_development_dependency 'did_you_mean'
  s.add_development_dependency 'annotate'
end
