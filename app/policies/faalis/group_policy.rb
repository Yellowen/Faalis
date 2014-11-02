module Faalis
  class GroupPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
