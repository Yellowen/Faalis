namespace :faalis do

  namespace :js do

    desc "Collect all the strings which marked for translation from javascript files"
    task :collect => :environment do
      `grunt --gruntfile #{Faalis::Engine.root}/lib/tasks/grunt/Gruntfile.js --base #{Faalis::Engine.root}/ nggettext_extract`
    end

    desc "Compile all the strings which marked for translation in javascript files"
    task :compile => :environment do
      `grunt --gruntfile #{Faalis::Engine.root}/lib/tasks/grunt/Gruntfile.js nggettext_compile`
    end


    task :remove_copyright_header do
      Dir.glob("{app,lib}/**/*.js").each do |file|
        puts ">> #{file}"
        c = File.open(file, "r").read
        c.gsub!(/\/\*.*Red Base.*\*\//mi, "")
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
