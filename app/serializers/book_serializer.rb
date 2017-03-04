class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :source_url, :tags
  has_many :libraries
  has_many :tags
end
