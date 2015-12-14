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

require 'i18n'
require 'devise'
require 'turbolinks'
require 'modernizr-rails'
require 'model_discovery'
require 'pundit'
require 'slim-rails'
require 'formtastic'
require 'kaminari'

# Faalis Module
module Faalis
  autoload :Configuration, 'faalis/configuration'
end

require 'faalis/engine'
require 'faalis/orm'
require 'faalis/concerns'
require 'faalis/dashboard'
require 'faalis/extension'
require 'faalis/omniauth'
require 'faalis/i18n'
require 'faalis/route'
require 'faalis/action_dispatch'
require 'faalis/discovery'
require 'faalis/fake_assets'
require 'faalis/version'
