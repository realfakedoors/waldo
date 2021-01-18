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
        top: 562,
        bottom: 415,
        left: 1082,
        right: 1161
      }
    ]
  },
  {
    name: "Lollapalooza",
    image_url: "lollapalooza.png",
    subjects: [
      {
        name: "Boogie Viking",
        image_url: "boogie-viking.png",
        top: 140,
        bottom: 55,
        left: 106,
        right: 183
      },
      {
        name: "Stompin' Steve",
        image_url: "stompin-steve.png",
        top: 366,
        bottom: 242,
        left: 1101,
        right: 1194
      },
      {
        name: "Introverted Uncle",
        image_url: "introverted-uncle.png",
        top: 408,
        bottom: 348,
        left: 448,
        right: 485
      },
      {
        name: "Morris",
        image_url: "morris.png",
        top: 463,
        bottom: 399,
        left: 326,
        right: 382
      }
    ]
  },
  {
    name: "Where's Waldo",
    image_url: "actual-wheres-waldo.jpg",
    subjects: [
      {
        name: "Officer Niceguy",
        image_url: "officer-niceguy.jpg",
        top: 576,
        bottom: 512,
        left: 25,
        right: 66
      },
      {
        name: "Smitten Chick",
        image_url: "smitten-chick.jpg",
        top: 584,
        bottom: 451,
        left: 439,
        right: 480
      },
      {
        name: "Ice Cream Lover",
        image_url: "ice-cream-lover.jpg",
        top: 176,
        bottom: 70,
        left: 668,
        right: 714
      },
      {
        name: "Waldo",
        image_url: "waldo.png",
        top: 397,
        bottom: 324,
        left: 1153,
        right: 1173
      }
    ]
  },
  {
    name: "Bartender's Challenge",
    image_url: "bartenders-challenge.png",
    subjects: [
      {
        name: "St. Germain",
        image_url: "st-germain.jpg",
        top: 503,
        bottom: 397,
        left: 212,
        right: 256
      },
      {
        name: "Cynar",
        image_url: "cynar.jpg",
        top: 511,
        bottom: 386,
        left: 734,
        right: 782
      },
      {
        name: "Tullamore Dew",
        image_url: "tullamore-dew.jpg",
        top: 596,
        bottom: 552,
        left: 838,
        right: 862
      },
      {
        name: "Pimm's",
        image_url: "pimms.jpeg",
        top: 420,
        bottom: 313,
        left: 432,
        right: 473
      },
      {
        name: "Tanqueray",
        image_url: "tanqueray.jpeg",
        top: 604,
        bottom: 554,
        left: 168,
        right: 193
      }
    ]
  },
  {
    name: "Gaming Convention",
    image_url: "gaming-convention.jpg",
    subjects: [
      {
        name: "Tree Trunks",
        image_url: "tree-trunks.jpg",
        top: 61,
        bottom: 46,
        left: 639,
        right: 659
      },
      {
        name: "Captain Buddies",
        image_url: "captain-buddies.jpg",
        top: 298,
        bottom: 264,
        left: 76,
        right: 119
      },
      {
        name: "Duck Hunt Dog",
        image_url: "duck-hunt.jpg",
        top: 456,
        bottom: 428,
        left: 620,
        right: 656
      },
      {
        name: "The Tick & Arthur",
        image_url: "the-tick-and-arthur.jpg",
        top: 624,
        bottom: 586,
        left: 496,
        right: 537
      },
      {
        name: "The Hound",
        image_url: "the-hound.jpg",
        top: 667,
        bottom: 644,
        left: 1097,
        right: 1119
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
    new_photo.scores.create!(time: 300, initials: ("A".."Z").to_a.sample(3).join(""))
  end
end