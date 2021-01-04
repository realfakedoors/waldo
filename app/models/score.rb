class Score < ApplicationRecord
  belongs_to :photo, dependent: :destroy
  
  validates :initials, :time, presence: true
  validates :initials, length: { is: 3 }
end
