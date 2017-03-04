class BookSerializer < ActiveModel::Serializer
  attributes :id
  has_many :libraries
  has_many :tags
end
