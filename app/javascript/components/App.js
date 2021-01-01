import React from 'react'

const App = () => {
  return (<div>Hello World!</div>);
}

export default App;

// import axios from 'axios'

// useEffect(()=>{
//   axios.get('/api/v1/airlines.json')
//   .then(resp => {
//     setAirlines(resp.data.data)
//   })
//   .catch(err => console.log(err) )
// }, [airlines.length])