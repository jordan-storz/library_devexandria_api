class Library < ApplicationRecord
  belongs_to :user, inverse_of: :user, autosave: true
  has_and_belongs_to_many :book
end
