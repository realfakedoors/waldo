class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  
  has_many :subjects
  has_many :scores
end
