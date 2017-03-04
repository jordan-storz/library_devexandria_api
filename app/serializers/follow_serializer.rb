class FollowSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :follower
  belongs_to :followee
end
