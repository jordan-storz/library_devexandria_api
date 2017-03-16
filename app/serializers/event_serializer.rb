class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :created_at
  has_one :user
  has_one :book
end
