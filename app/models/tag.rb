class Tag < ApplicationRecord
  has_and_belongs_to_many :books
  has_and_belongs_to_many :libraries
end
