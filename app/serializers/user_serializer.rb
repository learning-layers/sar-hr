class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :first_name, :last_name, :title, :status,
             :role, :peer_id, :skill_ids

  def include_role?
    current_user && current_user.admin?
  end
end
