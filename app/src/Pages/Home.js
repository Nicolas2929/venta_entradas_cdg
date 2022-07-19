import { Box } from '@mui/material';
import { width } from '@mui/system';
import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../Components/Page';

export default function Home() {
  const navigate = useNavigate();


  const item = ({ to, name, img }) => {
    return <Link to={to}><p>
      <div><img style={{ height: "60px", width: "60px" }} alt="" src={img} /></div>
      <div style={{ color: "white", fontFamily: "arial", fontSize: "15px", }}>{name}</div></p>
    </Link>
  }
  return (
    <Page>
      <div style={
        {
          minHeight: "100vh",
          backgroundImage: "url('/img/rojoo.jpg')",
          backgroundRepeat: "no-repeat",
          backgroundZide: "cover",
          backgroundPosition: "center",
          backgroundAttachment: "fixed",
          position: "absolute"
        }
      }>
        <h1>hola</h1>
        <Box sx={{ display: 'flex', gap: 28, alignItems: 'center', flexWrap: 'wrap' }}>
          {item({
            to: "usuario",
            name: "Usuario.",
            img: "2256990.png"
          })}
          {item({
            to: "evento",
            name: "evento.",
            img: "120.png"
          })}
          {item({
            to: "sector",
            name: "sector.",
            img: "100.png"
          })}
          {item({
            to: "ticket",
            name: "ticket.",
            img: "1.jpg"
          })}
          {item({
            to: "venta",
            name: "venta.",
            img: "22.png"
          })}
          {item({
            to: "orden_pago",
            name: "orden_pago.",
            img: "125.png"
          })}
        </Box>

      </div>

    </Page>
  );
}
