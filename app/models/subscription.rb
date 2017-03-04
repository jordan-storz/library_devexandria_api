class Subscription < ApplicationRecord
  belongs_to :subscriber, foreign_key: "subscriber_id", class_name: "User"
  belongs_to :subscribee, foreign_key: "subscribee_id", class_name: "User"
end
