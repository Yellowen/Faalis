require 'fileutils'
require 'spec_helper'
require 'generator_spec/test_case'
require 'generators/faalis/install_generator'

describe Faalis::Generators::InstallGenerator, type: :generator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../dummy/tmp', __FILE__)

  def file(path)
    p = File.expand_path('../../dummy/tmp', __FILE__)
    "#{p}/#{path}"
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
    assert_file file('config/initializers/faalis.rb')
    assert_file file('config/initializers/devise.rb')
    assert_file file('config/initializers/fast_gettext.rb')
    assert_file file('config/initializers/formstatic.rb')
    assert_file file('db/seeds.rb')
    assert_file file('app/controllers/api_controller.rb')
    assert_file file('app/policies/application_policy.rb')
  end

  it 'copies the Javascripts manifest for dashboard' do
    assert_file file('app/assets/javascripts/dashboard/application.js')
  end
end
