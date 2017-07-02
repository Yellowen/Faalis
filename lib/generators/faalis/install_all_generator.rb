module Faalis
  module Generators
    class InstallAllGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      class_option :mongoid, type: :boolean, default: false, desc: 'Use mongoid with faalis'

      desc 'Copy all the necessary files to use Faalis (migrations included)'
      hook_for :install_generator

      def copy_migrations
        rake('faalis:install:migrations') unless options[:mongoid]
      end

      def copy_install
        invoke 'faalis:install'
      end

    end
  end
end
