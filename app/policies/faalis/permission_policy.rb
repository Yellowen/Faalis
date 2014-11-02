module Faalis
  class PermissionPolicy < Faalis::ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
