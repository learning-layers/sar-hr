class SkillStubSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_count

  def user_count
    object.users.size
  end
end
