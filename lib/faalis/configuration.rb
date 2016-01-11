module Faalis::Configuration

  # Configure logger
  mattr_accessor :logger
  @@logger = Logger.new(STDOUT)

  # Dashboard url prefix
  mattr_accessor :dashboard_namespace
  @@dashboard_namespace = :dashboard

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
  attr_accessor :site_title
  @site_title = 'Faalis'

  mattr_accessor :slug

  # Dashboard default javascript manifest
  mattr_accessor :dashboard_js_manifest
  @@dashboard_js_manifest = 'dashboard/application.js'

  # Devise options
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  mattr_accessor :devise_options
  @@devise_options = [:database_authenticatable,
                      :registerable,
                      :recoverable,
                      :rememberable,
                      :trackable,
                      :lockable,
                      :timeoutable,
                      :validatable]

  mattr_accessor :devise_for
  @@devise_for = {}
end
