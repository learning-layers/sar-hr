class SkillPolicy < Struct.new(:user, :skill)
  class Scope < Struct.new(:user, :scope)
    def resolve
      # List all skills by default.
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    # Only admins are allowed to create skills
    user.admin?
  end

  def update?
    # Only admins are allowed to update skills
    user.admin?
  end

  def destroy?
    # Same as for updating
    update?
  end
end
