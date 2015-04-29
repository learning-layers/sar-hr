class UserStubSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :first_name, :last_name, :status
end
