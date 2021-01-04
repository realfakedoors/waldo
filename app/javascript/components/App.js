import React, { useState, useEffect } from "react";
import Photo from "./Photo";

import axios from "axios";

const App = () => {
  const [selectedPhoto, setSelectedPhoto] = useState(1);
  const [subjectData, setSubjectData] = useState([]);
  const [totalSubjectCount, setTotalSubjectCount] = useState(0);
  const [foundSubjects, setFoundSubjects] = useState([]);

  useEffect(() => {
    grabSubjectData(selectedPhoto);
  }, [selectedPhoto]);

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

  function tryCoords(name, x, y) {
    const target = subjectData.filter((subj) => subj.name === name)[0];
    const box = target.targetBox;
    if (box.left <= x && box.right >= x && box.bottom <= y && box.top >= y) {
      setFoundSubjects(foundSubjects.concat(target));
      console.log("yay! it's " + name);
    } else {
      console.log("nope! it's not " + name);
    }
  }
  
  function displayTimer(time){
    return (
      <div className="display-timer">
        {time}
      </div>
    );
  }
  
  function displayFoundCount(totalSubjects, foundSubjects){
    return (
      <div className="display-found-count">
        {`${foundSubjects} / ${totalSubjects}`}
      </div>
    );
  }
  
  function displayFoundSubject(subject){
    return (
      <li className="found-subject" key={subject.id}>
        {subject.name}
      </li>
    )
  }

  return (
    <div className="app-container">
      <Photo
        allSubjects={subjectData}
        foundSubjects={foundSubjects}
        tryCoords={tryCoords}
      />
      <nav className="info-panel">
        {displayTimer("1:06")}
        {displayFoundCount(totalSubjectCount, foundSubjects.length)}
        <ul className="found-subjects">
          {foundSubjects.map(displayFoundSubject)}
        </ul>
      </nav>
    </div>
  );
};

export default App;
