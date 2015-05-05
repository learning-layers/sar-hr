class UserStubSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :first_name, :last_name, :title, :status,
             :skill_count

  def skill_count
    object.skills.size
  end
end
