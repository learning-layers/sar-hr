class SessionSerializer < ActiveModel::Serializer
  attributes :token, :expires_on
  has_one :user
end
