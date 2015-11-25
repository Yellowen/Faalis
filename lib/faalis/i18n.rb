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

module Faalis
  # I18n related utility functions
  class I18n
    RTL = [:fa, :ar]

    def self.direction(locale)
      if RTL.include? locale.to_sym
        'rtl'
      else
        'ltr'
      end
    end

    module Locale
      def self.default_url_options
        binding.pry
        { :locale => I18n.locale }
      end
    end

    class MissingKeyHandler < ::I18n::ExceptionHandler
      def call(exception, locale, key, options)
        if exception.is_a?(MissingTranslation)
          puts "<<<<<<<<<<<<<,", key
          super
        else
          super
        end
      end
    end
  end
end
