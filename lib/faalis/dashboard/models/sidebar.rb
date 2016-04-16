module Faalis::Dashboard::Models
  class Item

    attr_reader :title, :url, :icon, :model, :members_only
    def initialize(title, options)
      @title = title
      @model = nil
      extract_options(options)
    end

    def visible?(user)
      return true if @model.nil?

      if @model.respond_to? :map
        permissions = @model.map do |model|
          # Find the appropriate policy for each model
          # and authorize the user against that.
          Pundit.policy!(user, model.to_sym).index?
        end
        # If user don't have access to none of the models
        # then the menu should not be visible
        permissions.any?
      else

        # Authorize the menu visibility against user and given model
        Pundit.policy!(user, @model.to_sym).index?
      end
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

    def initialize(title, options)
      children = options.delete :children
      if children
        @children = children.map do |child|
          Item.new(child.delete(:title), child)
        end
      end
      super
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

      menu(t('faalis.dashboard.user_messages'),
        icon: 'fa fa-envelope-o',
        model: 'Faalis::UserMessage') do

        item(I18n.t('faalis.dashboard.user_messages.inbox'),
          model: 'Faalis::UserMessage',
          url: Faalis::Engine.routes.url_helpers.dashboard_user_messages_path)
        item(I18n.t('faalis.dashboard.user_messages.sent'),
          model: 'Faalis::UserMessage',
          url: Faalis::Engine.routes.url_helpers.dashboard_user_messages_path)
        item(I18n.t('faalis.dashboard.user_messages.draft'),
          model: 'Faalis::UserMessage',
          url: Faalis::Engine.routes.url_helpers.dashboard_user_messages_path)

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
