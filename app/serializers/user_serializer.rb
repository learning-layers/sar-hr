class UserSerializer < UserStubSerializer
  attributes :role

  def include_role?
    current_user && current_user.admin?
  end
end
