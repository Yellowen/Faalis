module RedBase
  class Engine < ::Rails::Engine
    isolate_namespace RedBase

    config.autoload_paths << File.expand_path("../../", __FILE__)
    engine_name "red_base"

    # Configure logger
    @@logger = Logger.new(STDOUT)
    mattr_accessor :logger

    def self.setup
      yield self
    end

  end
end
