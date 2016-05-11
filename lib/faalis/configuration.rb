module Faalis
  module Configuration

    @@modules_to_load = {}

    # Configure logger
    mattr_accessor :logger do
      Logger.new(STDOUT)
    end

    # Dashboard url prefix
    mattr_accessor :dashboard_namespace do
      :dashboard
    end

    # ==> ORM configuration
    # Load and configure the ORM. Supports :active_record (default) and
    # :mongoid (bson_ext recommended) by default. Other ORMs may be
    # available as additional gems.
    # ORM name to use. either 'active_record' or 'mongoid'
    mattr_accessor :orm

    def orm=(orm_name)
      @@orm = orm_name
      require "devise/orm/#{orm_name}"
    end

    # We have to move this method somewhere else
    def collect_i18n_missing_keys=(value)
      if value
        ::I18n.exception_handler = Faalis::I18n::MissingKeyHandler.new
      end
    end

    # Site Title
    attr_accessor :site_title do
      'Faalis'
    end

    mattr_accessor :slug

    # Dashboard default javascript manifest
    mattr_accessor :dashboard_js_manifest do
      'dashboard/application.js'
    end

    # Devise options
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    mattr_accessor :devise_options do
      [:database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable,
        :lockable, :timeoutable, :validatable]
    end

    mattr_accessor :devise_for do
      {}
    end

    # Whether using UUID with models or not.
    mattr_accessor :use_uuid do
      false
    end

    mattr_accessor :amd_dir do
      'amd'
    end

    mattr_accessor :amd do
      true
    end

    @@modules_to_load[:amd] = ['amd']

    def load_dependencies_based_on_configuration

      @@modules_to_load.each do |k, v|
        v.map { |mod| require mod } if send(k)
      end
    end

    def enabled?(configuration)
      @@modules_to_load.include? configuration
    end
  end
end
