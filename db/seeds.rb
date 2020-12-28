scores = Score.create([
  {
    time: "122 seconds",
    initials: "ABC"
  },
  {
    time: "62 seconds",
    initials: "DEF"
  },
  {
    time: "12 seconds",
    initials: "GHI"
  },
  {
    time: "42 seconds",
    initials: "JKL"
  },
  {
    time: "28 seconds",
    initials: "MNO"
  },
])

photos = Photo.create([
  {
    name: "Total Rickall"
  }
])

subjects = Subject.create([
  {
    name: "Baby Wizard",
    photo: photos.first
  },
  {
    name: "Sleepy Gary",
    photo: photos.first
  },
  {
    name: "Shakespeare",
    photo: photos.first
  }
])