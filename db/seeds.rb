photos = [
  {
    name: "Total Rickall",
    image_url: "total-rickall.jpg",
    subjects: [
      {
        name: "Baby Wizard",
        image_url: "baby-wizard.png",
        top: 344,
        bottom: 240,
        left: 284,
        right: 324
      },
      {
        name: "Sleepy Gary",
        image_url: "sleepy-gary.png",
        top: 222,
        bottom: 0,
        left: 692,
        right: 752
      },
      {
        name: "Mushroom Man",
        image_url: "mushroom-man.jpg",
        top: 557,
        bottom: 415,
        left: 1082,
        right: 1150
      }
    ]
  }
]

photos.each do |photo|
  new_photo = Photo.create!(name: photo[:name], image_url: photo[:image_url])
  photo[:subjects].each do |subject|
    new_subject = new_photo.subjects.create!(name: subject[:name], image_url: subject[:image_url])
    new_subject.target_box = TargetBox.new(top: subject[:top], bottom: subject[:bottom], right: subject[:right], left: subject[:left])
  end
  10.times do 
    new_photo.scores.create!(time: rand(10..100), initials: ("A".."Z").to_a.sample(3).join(""))
  end
end