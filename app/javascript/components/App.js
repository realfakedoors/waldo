import React, { useState, useEffect, Fragment } from "react";

import IntroScreen from "./IntroScreen";
import GameOverScreen from "./GameOverScreen";
import Photo from "./Photo";
import Timer from "./Timer";

import axios from "axios";

const App = () => {
  const [selectedPhoto, setSelectedPhoto] = useState(0);

  const [subjectData, setSubjectData] = useState([]);
  const [photoInfo, setPhotoInfo] = useState([]);

  const [totalSubjectCount, setTotalSubjectCount] = useState(0);
  const [foundSubjects, setFoundSubjects] = useState([]);

  const [timerActive, setTimerActive] = useState(false);
  const [timerValue, setTimerValue] = useState(0);

  useEffect(() => {
    grabSubjectData(selectedPhoto);
    grabPhotoInfo(selectedPhoto);
  }, [selectedPhoto]);

  useEffect(() => {
    if (isGameOver()) {
      setTimerActive(false);
    }
  }, [foundSubjects.length]);

  function isGameOver() {
    if (
      foundSubjects.length > 0 &&
      foundSubjects.length === totalSubjectCount
    ) {
      return true;
    } else {
      return false;
    }
  }
  
  function resetGame(){
    setFoundSubjects([]);
    setTimerValue(0);
    setSelectedPhoto(0);
  }

  function grabSubjectData(photo_id) {
    axios
      .get(`api/v1/photos/${photo_id}/subjects`)
      .then((response) => {
        const targetBoxes = response.data.included;
        const subjects = response.data.data.map((subject) => {
          return {
            id: subject.id,
            name: subject.attributes.name,
            targetBox: targetBoxes.filter((box) => box.id === subject.id)[0]
              .attributes,
          };
        });
        setSubjectData(subjects);
        setTotalSubjectCount(subjects.length);
      })
      .catch((err) => console.log(err));
  }

  function grabPhotoInfo(photo_id) {
    axios
      .get(`api/v1/photos/${photo_id}/`)
      .then((response) => {
        if (response.data.data !== null) {
          setPhotoInfo(response.data.data.attributes);
        }
      })
      .catch((err) => console.log(err));
  }

  function tryCoords(name, x, y) {
    const target = subjectData.filter((subj) => subj.name === name)[0];
    const box = target.targetBox;
    if (box.left <= x && box.right >= x && box.bottom <= y && box.top >= y) {
      setFoundSubjects(foundSubjects.concat(target));
    } else {
      console.log("nope! it's not " + name);
    }
  }

  function displayFoundCount(totalSubjects, foundSubjects) {
    return (
      <div className="display-found-count">
        {`${foundSubjects} / ${totalSubjects}`}
      </div>
    );
  }

  function displayFoundSubject(subject) {
    return (
      <li className="found-subject" key={subject.id}>
        {subject.name}
      </li>
    );
  }
  
  function buildTimeString(time) {
    const seconds = time % 60;
    return `${Math.floor(time / 60)}:${seconds < 10 ? "0" : ""}${seconds}`;
  }

  let display;
  if (selectedPhoto === 0) {
    // Intro Screen: Select a photo
    display = (
      <Fragment>
        <IntroScreen
          setSelectedPhoto={setSelectedPhoto}
          setTimerActive={setTimerActive}
        />
      </Fragment>
    );
  } else if (isGameOver()) {
    // Game Over Screen: Enter time + initials
    display = (
      <Fragment>
        <GameOverScreen
          currentPhoto={selectedPhoto}
          photoName={photoInfo.name}
          resetGame={resetGame}
          time={timerValue}
          buildTimeString={buildTimeString}
        />
      </Fragment>
    );
  } else {
    display = (
      <Fragment>
        <Photo
          photoData={photoInfo.image_url}
          allSubjects={subjectData}
          foundSubjects={foundSubjects}
          tryCoords={tryCoords}
        />
        <nav className="info-panel">
          <Timer isActive={timerActive} setTimerValue={setTimerValue} buildTimeString={buildTimeString} />
          {displayFoundCount(totalSubjectCount, foundSubjects.length)}
          <ul className="found-subjects">
            {foundSubjects.map(displayFoundSubject)}
          </ul>
        </nav>
      </Fragment>
    );
  }

  return <div className="app-container">{display}</div>;
};

export default App;
