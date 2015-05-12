class UserSerializer < UserStubSerializer
  attributes :role, :peer_id, :skill_ids

  def include_role?
    current_user && current_user.admin?
  end
end
