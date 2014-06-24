namespace :faalis do

  namespace :js do

    namespace :i18n do
      desc "Collect all the strings which marked for translation from javascript files"
      task :collect => :environment do
        base = "--base #{Faalis::Engine.root}/ --base #{Rails.root}/"
        puts "grunt --gruntfile #{Rails.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_extract -d -v"
        puts `grunt --gruntfile #{Rails.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_extract -d -v`
      end

      desc "Compile all the strings which marked for translation in javascript files"
      task :compile => :environment do
        base = "--base #{Faalis::Engine.root}/ --base #{Rails.root}/"
        puts `grunt --gruntfile #{Rails.root}/lib/tasks/grunt/Gruntfile.js #{base} nggettext_compile -d -v`
      end

      desc "Compile all the strings which marked for translation in javascript files"
      task :help => :environment do
        puts `grunt --gruntfile #{Faalis::Engine.root}/lib/tasks/grunt/Gruntfile.js --help`
      end

    end
    task :remove_copyright_header do
      Dir.glob("{app,lib}/**/*.js").each do |file|
        puts ">> #{file}"
        c = File.open(file, "r").read
        c.gsub!(/\/\*.*Faalis.*\USA\.$/mi, "")
        c.gsub!(/^[\-]+ \*\/$/i, "")
        File.open(file, "w").write c
      end
    end

  end
end


namespace :gettext do
  def files_to_translate
    Dir.glob("{app,lib,config,locale}/**/*.{rb ,erb,haml,slim,rhtml,js.erb,handlebars.erb }")
  end
end
