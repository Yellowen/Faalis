$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "faalis/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "faalis"
  s.version     = Faalis::VERSION
  s.authors     = ["Sameer Rahmani", "Behnam Ahmad Khan Beigi"]
  s.email       = ["lxsameer@gnu.org", "yottanami@gnu.org"]
  s.homepage    = "https://github.com/Yellowen/Faalis"
  s.summary     = "Faalis is a ruby on rails engine which provides a very basic web application to use with other ruby on rails applications."
  s.description = "Faalis is a ruby on rails engine which provides a very basic web application to use with other ruby on rails applications."
  s.licenses = ["GPL-2"]
  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile",
                "README.md"]

  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 4.0.0"

  # Authentication
  s.add_dependency "omniauth"
  s.add_dependency "devise", ">= 3.0.0"

  # Authorization
  s.add_dependency "cancan"
  s.add_dependency "mailboxer"

  # API
  s.add_dependency "jbuilder"

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

  # model_discovery
  s.add_dependency "model_discovery", "~> 0.2.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "ruby_parser"
  s.add_development_dependency "rdoc"
  s.add_development_dependency 'rspec-rails', '~> 3.0.0.beta'
  s.add_development_dependency "capybara"
  s.add_development_dependency 'factory_girl_rails'

end
