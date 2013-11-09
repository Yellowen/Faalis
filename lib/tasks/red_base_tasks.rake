# desc "Explaining what the task does"
# task :red_base do
#   # Task goes here
# end


namespace :gettext do
  def files_to_translate
    Dir.glob("{app,lib,config,locale}/**/*.{rb ,erb,haml,slim,rhtml,js.erb,handlebars.erb }")
  end
end
