module Faalis
  class UserPolicy < Faalis::ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
