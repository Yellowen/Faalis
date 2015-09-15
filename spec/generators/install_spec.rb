require 'fileutils'
require 'spec_helper'
require 'generator_spec/test_case'
require 'generators/faalis/install_generator'

describe Faalis::Generators::InstallGenerator, type: :generator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../dummy/tmp', __FILE__)

  def file_exists(path)
    p = destination_root
    assert_file "#{p}/#{path}"
  end

  def content_of(path)
    full_path = "#{destination_root}/#{path}"
    File.read(full_path)
  end

  before :all do
    prepare_destination

    path = File.expand_path('../../dummy/tmp/', __FILE__)

    FileUtils.mkdir_p("#{path}/config")
    FileUtils.mkdir_p("#{path}/app/controllers")

    FileUtils.touch("#{path}/config/routes.rb")
    FileUtils.touch("#{path}/app/controllers/application_controller.rb")
    run_generator
  end

  it 'copies the config files' do
    file_exists('config/initializers/faalis.rb')
    file_exists('config/initializers/devise.rb')
    file_exists('config/initializers/formstatic.rb')
    file_exists('db/seeds.rb')
    file_exists('app/controllers/api_controller.rb')
    file_exists('app/policies/application_policy.rb')
  end

  it 'copies the Javascripts manifest for dashboard' do
    file_exists('app/assets/javascripts/dashboard/application.js')
  end

  it 'copies stylesheet filese' do
    file_exists('app/assets/stylesheets/dashboard/ltr/application.css')
    file_exists('app/assets/stylesheets/dashboard/rtl/application.css')
  end
end
