class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :remove_reason, :created_at, :updated_at
  has_one :user
  has_one :book
end
