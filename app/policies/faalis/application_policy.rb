# Main class for all the **Faalis** Policy classes.
# It's totally a minimume Policy.
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    return true if user.admin?
    false
  end

  def show?
    return true if user.admin?
    scope.where(:id => record.id).exists?
  end

  def create?
    return true if user.admin?
    false
  end

  def new?
    create?
  end

  def update?
    return true if user.admin?
    false
  end

  def edit?
    update?
  end

  def destroy?
    return true if user.admin?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
