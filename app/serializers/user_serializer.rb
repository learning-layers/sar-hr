class UserSerializer < UserStubSerializer
  attributes :first_name, :last_name, :role

  def include_role?
    current_user.admin?
  end
end
