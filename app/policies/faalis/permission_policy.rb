module Faalis
  class PermissionPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
