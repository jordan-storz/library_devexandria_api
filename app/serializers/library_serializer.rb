class LibrarySerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  has_many :books
end
