class Photo < ApplicationRecord
  has_many :subjects
  has_many :scores
end
