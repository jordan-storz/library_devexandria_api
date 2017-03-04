class User < ApplicationRecord
  has_one :library, inverse_of: :library, dependent: :destroy

  has_many :follower, through: :follower_follow, source: :follower
  has_many :follower_follow, foreign_key: :followee_id, class_name: "Follow"

  has_many :followee, through: :followee_follow, source: :followee
  has_many :followee_follow, foreign_key: :follower_id, class_name: "Follow"
end
