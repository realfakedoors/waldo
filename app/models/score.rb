class Score < ApplicationRecord
  validates :initials, :time, presence: true
  validates :initials, length: { is: 3 }
end
