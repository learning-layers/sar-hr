class UserStubSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :first_name, :last_name, :title, :status,
             :peer_id, :skill_ids
end
