module RedBase
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Copy all the necessary files to use Red Base"
      def copy_init_files
        template "devise.rb", "config/initializers/devise.rb"
      end
    end

  end
end
