$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "red_base/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "red_base"
  s.version     = RedBase::VERSION
  s.authors     = ["Sameer Rahmani"]
  s.email       = ["lxsameer@gnu.org"]
  s.homepage    = "https://github.com/Yellowen/Red_Base"
  s.summary     = "RedBase is a ruby on rails engine which provides a very basic web application to use with other ruby on rails applications."
  s.description = "RedBase is a ruby on rails engine which provides a very basic web application to use with other ruby on rails applications."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile",
                "README.rdoc"]

  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 4.0.0"

  # Authentication
  s.add_dependency "omniauth"
  s.add_dependency "devise", ">= 3.0.0"

  # Authorization
  s.add_dependency "cancan"

  # API
  s.add_dependency "grape"

  # Assets
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails", '>= 4.0.0'
  s.add_dependency 'compass-rails'
  s.add_dependency 'zurb-foundation', '~> 4.0.0'
  s.add_dependency "font-awesome-rails"
  s.add_dependency 'modernizr-rails'
  s.add_development_dependency "execjs"

  # i18n
  s.add_dependency "fast_gettext"
  s.add_development_dependency "gettext"
  s.add_dependency 'gettext_i18n_rails'

  # Forms
  s.add_dependency 'formtastic'


  s.add_development_dependency "sqlite3"
  s.add_development_dependency "ruby_parser"
  s.add_development_dependency "rdoc"

end
