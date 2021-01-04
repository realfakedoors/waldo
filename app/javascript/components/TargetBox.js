import React from "react";

const TargetBox = ({ top, bottom, left, right }) => {
  const sides = {
    // position offset to account for photo-container's padding:
    bottom: bottom + 10,
    left: left + 10,
    width: right - left,
    height: top - bottom,
  }
  
  return(
    <div className="target-box" style={sides}></div>
  );
}

export default TargetBox;
