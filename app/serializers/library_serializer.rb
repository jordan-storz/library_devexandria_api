class LibrarySerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  has_and_belongs_to_many :book
  has_many :subscription
end
