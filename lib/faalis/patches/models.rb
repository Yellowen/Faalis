if Faalis::ORM.active_record?
  # Add inline permissions to any active record models. So we can use them
  # to authorize user access.
  module ActiveRecord
    class Base
      include Faalis::Permissions
    end
  end
elsif Faalis::ORM.mongoid?
  # Add inline permissions to any mongoid document. So we can use them
  # to authorize user access.
  module Mongoid::Document
    include Faalis::Permissions
  end
end
