class Subject < ApplicationRecord
  belongs_to :photo, dependent: :destroy
  
  has_one :target_box
end
