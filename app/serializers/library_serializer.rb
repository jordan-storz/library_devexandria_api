class LibrarySerializer < ActiveModel::Serializer
  attributes :id, :user_id
  belongs_to :user
  has_many :books
  has_many :tags, through: :books
end
