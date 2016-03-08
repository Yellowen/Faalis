module Faalis
  class UserPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
