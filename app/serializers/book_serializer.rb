class BookSerializer < ActiveModel::Serializer
  attributes :id
  has_and_belongs_to_many :library
  has_and_belongs_to_many :tag
end
