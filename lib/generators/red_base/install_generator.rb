module RedBase
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Copy all the necessary files to use Red Base"
      class_option :orm

      def copy_init_files
        template "devise.rb", "config/initializers/devise.rb"
        template "red_base.rb", "config/initializers/red_base.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end

    end
  end
end
