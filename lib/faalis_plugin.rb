gem_group :development do
  gem "faalis", :path => File.expand_path('../../Red_Base', __FILE__)
  gem "pry"
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem "capybara"
  gem "factory_girl_rails", "~> 4.0", :require => false
  gem "database_cleaner"
  gem "email_spec"
  gem "cucumber-rails", :require => false
  gem "json_spec", :git => "git://github.com/Yellowen/json_spec.git"
  gem "capybara-webkit"
  gem 'sqlite3'

end

gem 'rails', '4.0.2'
gem 'globalize', '>= 4.0.0.alpha.2'
gem 'jbuilder', '~> 1.2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'


git :init
git :add => "."
git :commit => %Q{-a -m "Initial commit"}
