import { Button } from '@mui/material';
import * as React from 'react';
import MediaCard from '../Components/MediaCard';
import ModeToggle from '../Components/ModeToggle';
import Typography from '../Components/Typography';

export default function Test() {



  return (
    <div>
      <Typography />
      <ModeToggle />
      <div style={{ textAlign: "center", marginBottom: 45 }}>
        <Button variant="text">Text</Button>
        <Button variant="contained">Contained</Button>
        <Button variant="outlined">Outlined</Button>
      </div>
      <div style={{ display: "flex", justifyContent: "center" }}>
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
