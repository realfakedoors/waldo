class Score < ApplicationRecord
  belongs_to :photo, dependent: :destroy, optional: true
  
  validates :initials, :time, presence: true
  validates :initials, length: { in: 1..3 }
end
