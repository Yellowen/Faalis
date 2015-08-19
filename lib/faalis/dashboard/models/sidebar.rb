module Faalis::Dashboard::Models
  class Item

    attr_reader :title, :url, :icon, :model
    def initialize(title, options)
      @title = title
      extract_options(options)
    end

    private
      def extract_options(options)
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end
  end

  class Menu < Item
    def children
      @children || []
    end

    def add_child(child)
      @children ||= []
      @children << child
    end
  end

  class RootMenu < Array
    alias :add_child :<<
  end

  class Sidebar

    include ActionView::Helpers::TranslationHelper

    def initialize(title, **options)
      @title = title
      extract_options(options)
      @tree = RootMenu.new
      @current_node = @tree
    end

    def children
      @tree
    end

    def title
      @title || I18n.t('faalis.dashboard.sidebar.title')
    end

    def menu(name, **options, &block)
      item = Menu.new(name, options)


      @current_node.add_child item

      prev_node = @current_node
      @current_node = item

      block.call if block_given?

      @current_node = prev_node
    end

    def item(name, **options)
      item = Item.new(name, options)
      @current_node.add_child item
    end

    def faalis_entries
      menu(t('faalis.dashboard.user_management'),
           icon: 'fa fa-users',
           model: 'Faalis::User') do
        item(I18n.t('faalis.dashboard.users'),
             model: 'Faalis::User',
             url: Faalis::Engine.routes.url_helpers.dashboard_auth_users_path)

        item(I18n.t('faalis.dashboard.groups'),
             model: 'Faalis::Group',
             url: Faalis::Engine.routes.url_helpers.dashboard_auth_groups_path)
      end
    end

    private
      def extract_options(options)
        @icon  = options.delete(:icon)
        @id    = options.delete(:id)
        @class = options.delete(:class)
      end
  end
end
