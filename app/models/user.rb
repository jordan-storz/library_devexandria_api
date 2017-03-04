class User < ApplicationRecord
  has_one :library, inverse_of: :library, dependent: :destroy
  has_many :subscription, dependent: :destroy
  has_many :library, through: :subscription
end
