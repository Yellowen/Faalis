ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../test/dummy/config/environment", __FILE__)
require "rails/test_help"
#require "mocha/mini_test"

# FABRICATION -----------------------------------
require 'fabrication'

Fabrication.configure do |config|
  config.fabricator_path = 'test/fabricators/faalis/'
  config.path_prefix = Faalis::Engine.root
end

# MINITEST REPORTER -----------------------------
require "minitest/reporters"

Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new,
                         ENV,
                         Minitest.backtrace_filter)


class ActiveSupport::TestCase
  fixtures :all
end

# CAPYBARA ---------------------------------------
# Capybara and poltergeist integration
require 'minitest/rails/capybara'
require 'capybara/rails'
require 'capybara/poltergeist'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Assertions
  include Faalis::Engine.routes.url_helpers
  include Warden::Test::Helpers

  Warden.test_mode!

  after do
    Warden.test_reset!
  end
end

Capybara.javascript_driver = :poltergeist


# DATABASE CLEANER -------------------------------

require 'database_cleaner'
require 'minitest/around/spec'

class Minitest::Spec
  around do |tests|
    DatabaseCleaner.cleaning(&tests)
  end
end

# CONNECTION POOL --------------------------------
require 'connection_pool'

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || ::ConnectionPool::Wrapper.new(:size => 1) { retrieve_connection }
  end
end

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
