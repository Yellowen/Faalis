$:.push File.expand_path('../lib', __FILE__)

# Maintain Faalis gem's version:
require 'faalis/version'

# Describe Faalis gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'faalis'
  s.version     = Faalis::VERSION
  s.authors     = ['Sameer Rahmani', 'Behnam Ahmad Khan Beigi']
  s.email       = ['lxsameer@gnu.org', 'yottanami@gnu.org']
  s.homepage    = 'https://github.com/Yellowen/Faalis'
  s.summary     = 'Faalis is a ruby on rails engine which provides a very basic web application to use with other ruby on rails applications.'
  s.description = 'Faalis is a ruby on rails engine which provides a very basic web application to use with other ruby on rails applications.'
  s.required_ruby_version = '~> 2.0'

  s.licenses = ['GPL-2']
  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile',
                'README.md']

  s.test_files = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.add_dependency 'rails', '~>4.2.0'

  # Authentication
  s.add_dependency 'omniauth'
  s.add_dependency 'devise', '~>3.4.0'

  # Authorization
  s.add_dependency 'pundit'
  #s.add_dependency 'mailboxer'

  # API
  s.add_dependency 'jbuilder'

  # Assets
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails', '~> 5.0'

  s.add_dependency 'sprockets', '~>2.11.0'

  # TODO: It should be dependency of
  # dashboard or main template
  s.add_dependency 'modernizr-rails'
  s.add_dependency 'angularjs-rails', '~>1.2.16'
  s.add_dependency 'lodash-rails', '~>2.4'
  s.add_development_dependency 'execjs'

  # Fake gems provided by rails-assets
  # to use these gems user should add
  # `source 'http://rails-assets.org' to the
  # gemfile
  s.add_dependency 'rails-assets-angular-gettext'
  s.add_dependency 'rails-assets-ng-grid', '~>2.0.11'
  s.add_dependency 'rails-assets-restangular', '~>1.4.0'
  s.add_dependency 'rails-assets-ngQuickDate', '~>1.3.0'
  s.add_dependency 'rails-assets-select2', '~>3.5.0'
  s.add_dependency 'rails-assets-angular-ui-select2', '~>0.0.5'
  s.add_dependency 'rails-assets-ng-flow', '~>2.4.2'
  # i18n
  #s.add_dependency 'gettext'
  s.add_development_dependency 'gettext'
  s.add_dependency 'gettext_i18n_rails'

  # model_discovery
  s.add_dependency 'model_discovery', '~> 0.3.0'

  # To support multiple ORM at once
  s.add_dependency 'orm_adapter'

  #s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'ruby_parser'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec-rails', '~> 3.1.0'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'did_you_mean'
end
