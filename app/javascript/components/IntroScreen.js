import React, { useState, useEffect } from "react";
import PhotoCard from "./PhotoCard";

import axios from "axios";

const IntroScreen = ({ setSelectedPhoto, setTimerActive }) => {
  const [prospectivePhoto, setProspectivePhoto] = useState(0);
  const [allPhotos, setAllPhotos] = useState([]);

  useEffect(() => {
    grabPhotos();
  }, []);

  function grabPhotos() {
    axios
      .get(`api/v1/photos/`)
      .then((response) => {
        const photos = response.data.data.map((photo) => {
          return {
            id: photo.id,
            name: photo.attributes.name,
            image_url: photo.attributes.image_url,
            subjects: response.data.included.filter(
              (subject) => subject.relationships.photo.data.id === photo.id
            ),
          };
        });
        setAllPhotos(photos);
      })
      .catch((err) => console.log(err));
  }

  function displayPhoto(photo) {
    return (
      <span
        onClick={() => setProspectivePhoto(photo.id)}
        key={photo.id}
        style={{ cursor: "pointer" }}
      >
        <PhotoCard
          id={photo.id}
          title={photo.name}
          photoData={photo.image_url}
        />
      </span>
    );
  }

  function displaySubjects(photo) {
    return photo.subjects.map((subject) => {
      return (
        <PhotoCard
          key={subject.id}
          id={subject.id}
          title={subject.attributes.name}
          photoData={subject.attributes.image_url}
        />
      );
    });
  }
  
  function startGame() {
    setSelectedPhoto(prospectivePhoto);
    setTimerActive(true);
  }

  let display;
  if (prospectivePhoto === 0) {
    display = (
      <div className={"select-a-photo"}>
        Select a Photo:
        <div className={"card-display"}>{allPhotos.map(displayPhoto)}</div>
      </div>
    );
  } else {
    display = (
      <div className={"show-subjects"}>
        Here are your targets:
        <div className={"card-display"}>
          {displaySubjects(
            allPhotos.filter((photo) => photo.id === prospectivePhoto)[0]
          )}
        </div>
        Tag these people as quickly as possible!
        <div className="start-button" onClick={() => startGame()}>Start!</div>
      </div>
    );
  }

  return (
    <div className={"intro-screen"}>
      <h1 className={"intro-title"}>Tag, You're It!</h1>
      <h3 className={"intro-instructions"}>
        A "Where's Waldo" style photo tagging game: tag everyone in the photo
        correctly to win!
      </h3>
      {display}
    </div>
  );
};

export default IntroScreen;
