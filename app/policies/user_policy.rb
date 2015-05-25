class UserPolicy < Struct.new(:user, :user_record)
  class Scope < Struct.new(:user, :scope)
    def resolve
      # List all users by default.
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
    # Only admins are allowed to create users
    user.admin?
  end

  def update?
    # Only admins can update users, unless the users update themselves
    user.admin? || user == user_record
  end

  def destroy?
    # Same as for updating
    update?
  end
end
