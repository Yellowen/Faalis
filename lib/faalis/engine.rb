# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------
require 'modernizr-rails'
require 'model_discovery'
require 'pundit'
require 'slim-rails'
require 'formtastic'
require 'kaminari'

require_relative './middlewares/locale'


module Faalis

  # `Engine` class of **Faalis**.
  class Engine < ::Rails::Engine

    # TODO: Break this class to modules
    # TODO: Add a facility to allow developers to select
    #       features of faalis
    isolate_namespace Faalis
    engine_name 'faalis'

    # Map `api` to `API` in Rails autoload
    ActiveSupport::Inflector.inflections(:en) do |inflect|
      inflect.acronym 'API'
      inflect.acronym 'DSL'
    end

    config.generators do |g|
      g.test_framework      :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.integration_tool    :rspec
      g.assets              false
      g.helper              false
    end

    # Configure logger
    mattr_accessor :logger
    @@logger = Logger.new(STDOUT)

    # Permissions configuration
    mattr_accessor :models_with_permission

    # TODO: create a basic setup for this option
    @@models_with_permission = ['Faalis::User',
                                'Faalis::Group',
                               ]

    def self.models_with_permission=(value)
      @@models_with_permission.concat(value).uniq!
    end

    # Dashboard url prefix
    mattr_accessor :dashboard_namespace
    @@dashboard_namespace = :dashboard

    # ==> ORM configuration
    # Load and configure the ORM. Supports :active_record (default) and
    # :mongoid (bson_ext recommended) by default. Other ORMs may be
    # available as additional gems.
    # ORM name to use. either 'active_record' or 'mongoid'
    mattr_accessor :orm

    def self.orm=(orm_name)
      @@orm = orm_name
      require "devise/orm/#{orm_name}"
      #require 'mailboxer'
    end

    def self.setup
      yield self
    end

    # Site Title
    mattr_accessor :site_title
    @@site_title = I18n.t('faalis.engine_name')

    mattr_accessor :slug


    # Override devise layout
    config.to_prepare do
      Devise::SessionsController.layout 'faalis/simple'
      Devise::RegistrationsController.layout  'faalis/simple'
      Devise::ConfirmationsController.layout 'faalis/application'
      Devise::UnlocksController.layout 'faalis/application'
      Devise::PasswordsController.layout 'faalis/application'
    end
    #Devise.omniauth_path_prefix = ["/en", "/fa"]

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

    middleware.use Faalis::Middlewares::Locale

  end
end
