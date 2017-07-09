ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths = migrations_paths

require 'simplecov'

SimpleCov.start 'rails'

require "rails/test_help"
require "minitest/reporters"
require 'fabrication'


# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new
Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new,
                         ENV,
                         Minitest.backtrace_filter)

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
