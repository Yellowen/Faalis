# -----------------------------------------------------------------------------
#    Red Base - Basic website skel engine
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
require 'fast_gettext'
require "gettext"
require "ruby_parser"
require 'gettext_i18n_rails'
require 'modernizr-rails'
require "compass-rails"
require 'zurb-foundation'
require "font-awesome-rails"
require "devise"
require "warden"
require "ember-rails"
require "ember/source"
require "grape"


module RedBase
  class Engine < ::Rails::Engine
    isolate_namespace RedBase

    #require 'red_base/initialize'

    engine_name "red_base"

    # Configure logger
    mattr_accessor :logger
    @@logger = Logger.new(STDOUT)

    # Permissions configuration
    mattr_accessor :models_with_permission

    # TODO: create a basic setup for this option
    @@models_with_permission = []

    def models_with_permission=(value)
        @@models_with_permission.concat(value).uniq!
    end

    # Dashboard configurations
    mattr_accessor :dashboard_modules

    # This class variable should be a hash
    # that each key is a resource name and its value
    # is some of these:
    #       resource: provide resource name explicitly
    #       title: resource title (will show in dashboard)
    #       icon: icon class checkout font-awesome
    @@dashboard_modules = {
      :users => {},
    }


    def dashboard_modules=(value)
        @@dashboard_modules.merge!(value)
    end

    # Dashboard url prefix
    mattr_accessor :dashboard_namespace
    @@dashboard_namespace = :dashboard

    mattr_accessor :layout_direction
    @@layout_direction = :ltr


    # locales
    mattr_accessor :locales
    @@locales = ['en', 'fa']

    def self.setup
      yield self
    end

    # Fast Gettext Configuration
    # TODO: Check for possible error in this configurations
    FastGettext.add_text_domain 'app', :path => 'config/locales', :type => :po
    # All languages you want to allow
    FastGettext.default_available_locales = @@locales
    FastGettext.default_text_domain = 'app'

    # Site Title
    mattr_accessor :site_title
    @@site_title = _("Red Base")

    # Override devise layout
    config.to_prepare do
      Devise::SessionsController.layout "red_base/application"
      Devise::RegistrationsController.layout  "red_base/application"
      Devise::ConfirmationsController.layout "red_base/application"
      Devise::UnlocksController.layout "red_base/application"
      Devise::PasswordsController.layout "red_base/application"
    end

    # Emberjs variant
    config.ember.variant = Rails.env
    config.ember.ember_path = "red_base/dashboard"
    config.handlebars.templates_root = "red_base/dashboard/templates/"

    # Grape configuration
    config.paths.add "app/api", glob: "**/*.rb"
    config.autoload_paths += Dir["#{Rails.root}/app/api/*", "../../app/api/"]

  end
end
