import { Button } from '@mui/material';
import * as React from 'react';
import MediaCard from './Components/MediaCard';
import ModeToggle from './Components/ModeToggle';
import Typography from './Components/Typography';

function App() {

  const callServer = () => {

    var data = {
      component: "usuario", type: "getAll",

    }
    const options = {
      method: 'POST',
      body: JSON.stringify(data),
    };

    fetch('http://localhost:8080/api', options)
      .then(response => response.json())
      .then(response => {
        console.log(response)
      })
      .catch(err => console.error(err));
  }

  return (
    <div>
      <Typography/>
      <ModeToggle />
      <div style={{textAlign:"center", marginBottom:45}}>
      <Button variant="text">Text</Button>
      <Button variant="contained">Contained</Button>
      <Button variant="outlined">Outlined</Button>
      </div>
      <div style={{display:"flex", justifyContent:"center"}}>
        <div>
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
        </div>
        <div>
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
        </div>
        <div>
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
        </div>
        <div>
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
          <MediaCard />
        </div>
      </div>
      
      
    </div>
  );
}

export default App;
