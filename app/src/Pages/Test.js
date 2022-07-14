import { Button } from '@mui/material';
import * as React from 'react';
import MediaCard from '../Components/MediaCard';
import ModeToggle from '../Components/ModeToggle';
import Titulo from '../Components/Titulo';
import TopBar from '../Components/TopBar';
import Typography from '../Components/Typography';

export default function Test() {



  return (
    <div>
      <TopBar />
      <Titulo title={"Test"} subTitle={"sadhasd"} />
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
