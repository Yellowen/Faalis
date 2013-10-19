module RedBase
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/', __FILE__)

      desc "Copy all templates to and assets to main application"

      def copy_views_file
        directory "views/red_base", "app/views/red_base"
        directory "views/layouts/red_base", "app/views/layouts/red_base"
      end

      def copy_assets_file
        directory "assets/javascripts/red_base", "app/assets/javascripts/red_base"
        directory "assets/stylesheets/red_base", "app/assets/stylesheets/red_base"
        directory "assets/images/red_base", "app/assets/images/red_base"

      end

    end
  end
end
