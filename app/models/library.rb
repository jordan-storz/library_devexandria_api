class Library < ApplicationRecord
  belongs_to :user, autosave: true
  has_and_belongs_to_many :books
end
