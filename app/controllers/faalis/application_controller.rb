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
class Faalis::ApplicationController < ActionController::Base
  include FastGettext::Translation
  before_filter :set_locale


  def set_locale
    FastGettext.add_text_domain 'faalis', :path => "#{Faalis::Engine.root}/config/locales", :type => :po
    # All languages you want to allow
    FastGettext.default_available_locales = Faalis::Engine.locales
    FastGettext.default_text_domain = 'faalis'

    lang = request.env['lang'] || params[:locale] || session[:locale] || I18n.default_locale
    FastGettext.set_locale(lang.to_sym)
    session[:locale] = I18n.locale = lang
  end
end
