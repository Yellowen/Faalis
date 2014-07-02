case Faalis::ORM.current
when 'active_record'
  # Add inline permissions to any active record models. So we can use them
  # to authorize user access.
  module ActiveRecord
    class Base
      include Faalis::Concerns::Authorizable
    end
  end
end
#when 'mongoid'
  # Add inline permissions to any mongoid document. So we can use them
  # to authorize user access.
  # FIXME: Check why `Faalis::Permissions` does not add to Document class
#module Mongoid
    #module Document
      #include Faalis::Permissions
    #end
  #end
#end
