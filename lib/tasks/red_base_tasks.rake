namespace :red_base do

  namespace :js do


    desc "Collect all the strings which marked for translation from javascript files"
    task :collect => :environment do
      pattern = /<\%= _\([\"|\']([^\"\']*)[\"|\']\) \%>/im

      # Create translate_struct which contains all strings in all locals
      available_locales = I18n.available_locales
      translate_struct = {}
      available_locales.each do |lang|
        translate_struct[lang] = {}
      end
      # ---------------------------------------

      path = "app/assets/javascripts/red_base/dashboard/mixins/**/*.{js,js.erb}"
      #path = "app/assets/javascripts/red_base/dashboard/templates/**/*.{handlebars,handlebars.erb}"

      files = Dir.glob(path)
      files.each do |filename|
        print "Scaning file: #{filename.split("/")[-1]} . . .\n"

        data = File.open(filename).read
        matches = data.scan(pattern).to_a

        matches.each do |str|
          #print "Found: #{str[0]}\n"
          data.gsub!(/[\"|\']<\%= _\([\"|\']#{str[0]}[\"|\']\) \%>[\"|\']/, "_('#{str[0]}')")

        end

        File.open(filename, "w").write(data)

      end
    end
  end

end


namespace :gettext do
  def files_to_translate
    Dir.glob("{app,lib,config,locale}/**/*.{rb ,erb,haml,slim,rhtml,js.erb,handlebars.erb }")
  end
end
