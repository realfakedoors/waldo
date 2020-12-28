class ScoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :initials
end
