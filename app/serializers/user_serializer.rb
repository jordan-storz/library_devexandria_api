class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :library
  has_one :library
  has_many :followers
  has_many :followees
end
