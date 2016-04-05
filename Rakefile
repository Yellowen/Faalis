import 'docs/guides/Rakefile'

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler.setup(ENV['RAILS_ENV'] || :default)

APP_RAKEFILE = File.expand_path('../test/dummy/Rakefile', __FILE__)

#load 'rails/tasks/engine.rake'
load 'rails/tasks/engine.rake'
load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks

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

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
