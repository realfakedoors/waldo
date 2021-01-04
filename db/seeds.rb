photos = [
  {
    name: "Total Rickall",
    subjects: [
      {
        name: "Baby Wizard",
        top: 330,
        bottom: 240,
        left: 284,
        right: 324
      },
      {
        name: "Sleepy Gary",
        top: 212,
        bottom: 0,
        left: 692,
        right: 752
      },
      {
        name: "Mushroom Man",
        top: 547,
        bottom: 415,
        left: 1082,
        right: 1140
      }
    ]
  }
]

photos.each do |photo|
  new_photo = Photo.create!(name: photo[:name])
  photo[:subjects].each do |subject|
    new_subject = new_photo.subjects.create!(name: subject[:name])
    new_subject.target_box = TargetBox.new(top: subject[:top], bottom: subject[:bottom], right: subject[:right], left: subject[:left])
  end
  10.times do 
    new_photo.scores.create!(time: rand(10..100), initials: ("A".."Z").to_a.sample(3).join(""))
  end
end