# Main class for all the **Faalis** Policy classes.
# It's totally a minimume Policy.
class Faalis::ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def authorize?(action)
    return false if @user.nil?
    return true if @user.admin?

    # Check for ownership of the reocrd
    record_class = @record.class

    unless [Class, String, Symbol].include?(record_class)
      if @user.has_ownership?(@record)
        return false if !@user.owned? @record
      end
      @record = @record.class
    end

    user.can? action, @record.to_s
  end

  def method_missing(m, *args, &block_given)
    return authorize? m.to_s[0..-2] if m.to_s =~ /.*\?$/
    super
  end


  def scope
    Pundit.policy_scope!(@user, record.class)
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
