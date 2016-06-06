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

require_relative './middlewares/locale'
require_relative './configuration'

module Faalis

  # `Engine` class of **Faalis**.
  class Engine < ::Rails::Engine
    extend ::Faalis::Configuration

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
      g.test_framework      :minitest, fixture_replacement: :fabrication
      g.fixture_replacement :fabrication, dir: "test/fabricators"
      g.integration_tool    :minitest
      g.assets              false
      g.helper              false
    end

    # The actual setup method which is responsible for configuring
    # `Faalis` environment. This method simply yield the current
    # class and allows developers to change the configuration via
    # the class methods defined in `Faalis::Configuration` ( which is
    # extended in this class ).
    def self.setup
      yield self

      # Load the dependencies needed by each particular feature.
      load_dependencies_based_on_configuration
    end

    # Override devise layout
    config.to_prepare do
      Devise::SessionsController.layout 'faalis/simple'
      Devise::RegistrationsController.layout  'faalis/simple'
      Devise::ConfirmationsController.layout 'faalis/application'
      Devise::UnlocksController.layout 'faalis/application'
      Devise::PasswordsController.layout 'faalis/application'
    end

    middleware.use Faalis::Middlewares::Locale

  end
end
