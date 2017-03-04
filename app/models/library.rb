class Library < ApplicationRecord
  belongs_to :user, inverse_of: :user
  has_and_belongs_to_many :book
  has_many :subscription, dependent: :destroy
  has_many :user, through: :subscription
end
