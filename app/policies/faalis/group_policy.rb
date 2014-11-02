module Faalis
  class GroupPolicy < Faalis::ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
