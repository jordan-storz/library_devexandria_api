class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_one :library
  has_many :followers
  has_many :followees
end
