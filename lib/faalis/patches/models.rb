# Add inline permissions to any active record models. So we can use them
# to authorize user access.
module ActiveRecord
  class Base
    include Faalis::Concerns::Authorizable
  end
end
