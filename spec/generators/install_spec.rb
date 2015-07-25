require 'fileutils'
require 'spec_helper'
require 'generator_spec/test_case'
require 'generators/faalis/install_generator'

describe Faalis::Generators::InstallGenerator, type: :generator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../dummy/tmp', __FILE__)

  before do
    prepare_destination

    path = File.expand_path('../../dummy/tmp/', __FILE__)

    FileUtils.mkdir_p("#{path}/config")
    FileUtils.mkdir_p("#{path}/app/controllers")

    FileUtils.touch("#{path}/config/routes.rb")
    FileUtils.touch("#{path}/app/controllers/application_controller.rb")
    run_generator
  end

  it 'copies the config files' do
    assert_file "config/initializers/faalis.rb"
  end

end
