namespace :red_base do

  namespace :js do

    # Discover all the strings marked for translation based on
    # pattern in files provided by path
    def find_string(path, pattern, init_data)

      result = init_data

      files = Dir.glob(path)
      files.each do |filename|
        print "Scaning file: #{filename.split("/")[-1]} . . .\n"

        data = File.open(filename).read
        matches = data.scan(pattern).to_a

        matches.each do |str|
          print "Found: #{str[0]}\n"
          if not result.include? str[0]
            result[str[0]] = ""
          end
        end
      end

      return result
    end

    # Write down the translte json
    def write_down(struct)

      # Create local path if does not exists
      locale_path = "app/assets/javascripts/red_base/locale"
      if not File::directory? (locale_path)
        Dir::mkdir(locale_path)
      end

      struct.each do |lang, string_struct|
        data = {}
        if File::exists?("#{locale_path}/#{lang}.json")
          data = JSON.load(File.open("#{locale_path}/#{lang}.json"))
        end

        string_struct.each do |key, value|
          if not data.include? key
            data[key] = value
          end
        end
        data = JSON.pretty_generate(data)
        File.open("#{locale_path}/#{lang}.json", 'w').write(data)

      end
    end

    desc "Collect all the strings which marked for translation from javascript files"
    task :collect => :environment do
      jspattern = /_\([\"|\']([^\"\']*)[\"|\']\)/im
      htmlpattern = /_ [\"|\']([^\"\']*)[\"|\']/im

      # Create translate_struct which contains all strings in all locals
      available_locales = I18n.available_locales
      translate_struct = {}
      # ---------------------------------------

      jspath = "app/assets/javascripts/red_base/dashboard/**/*.{js,js.erb}"
      htmlpath = "app/assets/javascripts/red_base/dashboard/templates/**/*.{handlebars,handlebars.erb}"

      result = {}
      result = find_string(jspath, jspattern, result)
      result = find_string(htmlpath, htmlpattern, result)

      available_locales.each do |lang|
        translate_struct[lang] = result
      end

      write_down(translate_struct)
    end
  end

end


namespace :gettext do
  def files_to_translate
    Dir.glob("{app,lib,config,locale}/**/*.{rb ,erb,haml,slim,rhtml,js.erb,handlebars.erb }")
  end
end
