module Faalis
  module Concerns::User::Gravatar
    def gravatar
      require 'digest/md5'
      hash = Digest::MD5.hexdigest(email.downcase)

      # compile URL which can be used in <img src="RIGHT_HERE"...
      "http://www.gravatar.com/avatar/#{hash}"
    end
  end
end
