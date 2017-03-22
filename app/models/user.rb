class User < ApplicationRecord
  has_one :library, dependent: :destroy

  has_many :followers, through: :follower_follow, source: :follower
  has_many :follower_follow, foreign_key: :followee_id, class_name: "Follow", autosave: true

  has_many :followees, through: :followee_follow, source: :followee
  has_many :followee_follow, foreign_key: :follower_id, class_name: "Follow", autosave: true

  has_many :events
end
