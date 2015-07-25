source 'http://rubygems.org'
source 'http://rails-assets.org'
# Declare your gem's dependencies in faalis.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

dashstrap = [File.expand_path(File.dirname(__FILE__)),
             '../dashstrap'].join('/')

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'factory_girl'
  gem 'yard'
  gem 'redcarpet'
  gem 'github-markup'
  gem 'sqlite3'
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-doc'
  gem 'faker'
  gem 'rake'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'shoulda'
  #gem 'did_you_mean', github: 'yuki24/did_you_mean'
  gem 'slim-rails'
  gem 'dashstrap', path: dashstrap
  gem 'turbolinks', github: 'rails/turbolinks'
  gem 'jquery-turbolinks'
  gem 'capybara-webkit'
end

gem 'codeclimate-test-reporter', group: :test, require: nil
