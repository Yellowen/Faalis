require 'rubygems'
import 'docs/guides/Rakefile'

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

#Bundler.setup(ENV['RAILS_ENV'] || :default)

APP_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'

desc "Generate and deploy all docs"
task docs: ['guides:generate', 'guides:deploy'] do
  pwd = Dir.pwd

  system('bundle exec yardoc')

  system("cp -r #{pwd}/docs/ruby /tmp/ruby")
  Dir.chdir '/tmp/ruby' do
    system('git init')
    system('git remote add origin git@github.com:Yellowen/faalis_apidoc.git')
    system('git checkout -b gh-pages')
    system('echo "api.faalis.io" > CNAME')
    system('git add .')
    system('git commit -a -m "new release"')
    system('git push origin gh-pages -f')
  end

  system("rm -rf /tmp/ruby ")
end

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(spec: 'app:db:test:prepare')
task default: :spec
