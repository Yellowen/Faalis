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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "devise", "~> 3.0.0"

  s.add_development_dependency "sqlite3"
end
