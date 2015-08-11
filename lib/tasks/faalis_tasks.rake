require 'faalis'
namespace :js do
  namespace :i18n do

    desc "Collect all the strings which marked for translation from javascript files"
    task :collect do
      base = "--base #{Rails.root}/"
      puts "grunt --gruntfile #{Rails.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_extract -d -v"
      puts `grunt --gruntfile #{Rails.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_extract -d -v`
    end

    desc "Compile all the strings which marked for translation in javascript files"
    task :compile do
      base = "--base #{Rails.root}/"
      puts `grunt --gruntfile #{Rails.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_compile -d -v`
    end
  end

end


namespace :faalis do
  namespace :js do
    namespace :i18n do
      desc "Collect all the strings which marked for translation from javascript files"
      task :collect do
        base = "--base #{Faalis::Engine.root}/"
        puts "grunt --gruntfile #{Faalis::Engine.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_extract -d -v"
        puts `grunt --gruntfile #{Faalis::Engine.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_extract -d -v`
      end

      desc "Compile all the strings which marked for translation in javascript files"
      task :compile do
        base = "--base #{Faalis::Engine.root}/"
        puts `grunt --gruntfile #{Faalis::Engine.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_compile -d -v`
      end
    end
  end
end
