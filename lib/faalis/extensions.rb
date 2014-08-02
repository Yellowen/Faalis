module Faalis
  # Extension module of Faalis which contains all the related
  # stuff to a Faalis extension.
  module Extension

    @@extensions = {}

    def self.extensions
      @@extensions
    end

    def self.extensions=(value)
      @@extensions = value
    end
  end
end

require 'faalis/extensions/base'
