namespace :faalis do
  namespace :i18n do
    desc 'Add all the missing keys to the locale files'
    task :collect do
      def merge_recursively(a, b)
        a.merge(b) {|key, a_item, b_item| merge_recursively(a_item, b_item) }
      end

      Dir["#{Rails.root}/tmp/i18n/*"].each do |locale_file|
        locale = locale_file.split('/')[-1]
        if File.exist? "#{Rails.root}/config/locales/#{locale}.yml"
          raw_data = File.read("#{Rails.root}/config/locales/#{locale}.yml")
          locale_data = YAML.load(raw_data)
        else
          locale_data = {}
        end

        Dir["#{Rails.root}/tmp/i18n/#{locale}/*"].each do |key_file|
          key   = key_file.split('/')[-1]
          title = key.split('.')[-1].titleize
          array = ::I18n.normalize_keys(locale, key, nil)
          tmp   = array.reverse.inject(title) do |a, n|
            { n.to_s => a }
          end

          locale_data = merge_recursively(locale_data, tmp)
        end

        puts YAML.dump(locale_data)[4..-1]
      end
    end
  end
end
