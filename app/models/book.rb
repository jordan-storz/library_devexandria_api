class Book < ApplicationRecord
  has_and_belongs_to_many :libraries
  has_and_belongs_to_many :tags, autosave: true
end
