class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_one :library
  has_many :subscription
end
