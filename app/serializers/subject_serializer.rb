class SubjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  
  has_one :target_box
  belongs_to :photo
end
