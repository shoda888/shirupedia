class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_one :profile,  serializer: ProfileSerializer
end
