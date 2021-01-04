class TargetBox < ApplicationRecord
  belongs_to :subject, dependent: :destroy
end
