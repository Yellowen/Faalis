say

app_name = ask("What's your app name: ")

gem_group :development do
  gem "pry"
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem "capybara"
  gem "factory_girl_rails", "~> 4.0", :require => false
  gem "database_cleaner"
  gem "email_spec"
  gem "cucumber-rails", :require => false
  gem "json_spec", :git => "git://github.com/Yellowen/json_spec.git"
  gem "capybara-webkit"
end

gsub_file "#{app_name}.gemspec", /test\/\*\*\/\*/, "spec/**/*"

insert_into_file "#{app_name}.gemspec", :after => 's.add_development_dependency "sqlite3"' do
  "\n  s.add_dependency 'globalize', '>= 4.0.0.alpha.2'\n"
end

insert_into_file "#{app_name}.gemspec", :after => 's.add_development_dependency "sqlite3"' do
  "\n  s.add_dependency 'jbuilder', '~> 1.2'\n"
end
insert_into_file "#{app_name}.gemspec", :after => 's.add_development_dependency "sqlite3"' do
  "\n  s.add_dependency 'sass-rails', '~> 4.0.0'\n"
end
insert_into_file "#{app_name}.gemspec", :after => 's.add_development_dependency "sqlite3"' do
  "\n  s.add_dependency 'uglifier', '>= 1.3.0'\n"
end
insert_into_file "#{app_name}.gemspec", :after => 's.add_development_dependency "sqlite3"' do
  "\n  s.add_dependency 'jquery-rails'\n"
end
insert_into_file "#{app_name}.gemspec", :after => 's.add_development_dependency "sqlite3"' do
  "\n  s.add_dependency 'faalis'\n"
end

inside "app/assets/javascripts/" do
  run "touch #{app_name.underscore.downcase}/application.js"
end
append_file "app/assets/javascripts/#{app_name.underscore.downcase}/application.js" do <<-'FILE'
//= require_tree 'modules'
FILE
end

gsub_file "lib/#{app_name}.rb", /require '#{app_name}\/engine'/, ""
append_file "lib/#{app_name}.rb", "\nrequire '#{app_name}/engine'"
gsub_file "Gemfile", /https/, "http"

gsub_file "lib/#{app_name}/engine.rb", /module #{app_name.camelize}\n/, %Q{if File.exists?([File.expand_path("../../../", __FILE__),
                 ".development"].join("/"))
  $LOAD_PATH <<  File.expand_path('../../../../Faalis/lib', __FILE__)
end

require "faalis"


module #{app_name.camelize}
}

insert_into_file "lib/#{app_name}/engine.rb", :after => "  class Engine < ::Rails::Engine\n" do
  %Q{  engine_name "#{app_name}"

    ::Faalis::Engine.setup do |config|
      config.models_with_permission = []
    end

    ::Faalis::Plugins.register "#{app_name}", self
}
end


git :init

create_file ".gitignore" do
  %Q{
.bundle/
log/*.log
*~
pkg/
test/dummy/db/*.sqlite3
test/dummy/db/*.sqlite3-journal
test/dummy/log/*.log
test/dummy/tmp/
test/dummy/.sass-cache
spec/dummy/db/*.sqlite3
spec/dummy/db/*.sqlite3-journal
spec/dummy/log/*.log
spec/dummy/tmp/
spec/dummy/.sass-cache

*.rbc
*.sassc
.sass-cache
capybara-*.html
.rspec
.rvmrc
/.bundle
/vendor/bundle
/log/*
/tmp/*
/db/*.sqlite3
/public/system/*
/coverage/
/spec/tmp/*
**.orig
rerun.txt
pickle-email-*.html
.project
config/initializers/secret_token.rb
.*\#*#
\#*#
docs/*
node_modules/
.development
doc/
}
end
git :add => "."
git :commit => %Q{-a -m "Initial commit"}
