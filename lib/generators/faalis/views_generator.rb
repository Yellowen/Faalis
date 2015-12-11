module Faalis
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/', __FILE__)

      desc "Copy given views of a resource to the main application"
      argument :resource_name , type: :string, required: true
      argument :views_to_copy , type: :array, default: []

      def copy_views
        if views_to_copy.empty?
          views = ['index', 'show', 'new', 'edit', 'create', 'update', 'destroy']
        else
          views = views_to_copy
        end

        empty_directory "app/views/#{resources}"

        if views.include? 'index'
          copy_file 'views/faalis/dashboard/resource/index.html.slim', "app/views/#{resources}/index.html.slim"
        end

        if views.include? 'show'
          copy_file 'views/faalis/dashboard/resource/show.html.slim', "app/views/#{resources}/show.html.slim"
        end

        if views.include? 'new'
          copy_file 'views/faalis/dashboard/resource/new.html.slim', "app/views/#{resources}/new.html.slim"
          copy_file 'views/faalis/dashboard/resource/_form.html.slim', "app/views/#{resources}/_form.html.slim"
        end

        if views.include? 'edit'
          copy_file 'views/faalis/dashboard/resource/edit.html.slim', "app/views/#{resources}/edit.html.slim"
          copy_file 'views/faalis/dashboard/resource/_form.html.slim', "app/views/#{resources}/_form.html.slim"
        end

        if views.include? 'create'
          copy_file 'views/faalis/dashboard/resource/create.js.erb', "app/views/#{resources}/create.js.erb"
        end

        if views.include? 'update'
          copy_file 'views/faalis/dashboard/resource/update.js.erb', "app/views/#{resources}/update.js.erb"
        end

        if views.include? 'destroy'
          copy_file 'views/faalis/dashboard/resource/destroy.js.erb', "app/views/#{resources}/destroy.js.erb"
        end
      end

      private

      def resources
        resource_name.underscore.pluralize
      end
    end
  end
end
