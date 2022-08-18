import { Box } from '@mui/material';
import { width } from '@mui/system';
import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../../Components/Page';
import Button from '@mui/material/Button';
import Model from '../../Model';

export default function Home() {
  const navigate = useNavigate();


  const item = ({ to, name, img }) => {
    return <Link to={to} style={{
      textDecoration: "none",
      color: "#000",
      fontFamily: "arial", fontSize: "16px",
      // fontWeight: "bold"
    }}>
      <p style={{
        textAlign: "center"
      }}>
        <div style={{
          textAlign: "center"
        }}><img style={{ height: "60px", width: "60px" }} alt="" src={img} /></div>
        <label style={{ textAlign: "center", textDecoration: "none" }}>{name}</label>
      </p>
    </Link>
  }

  // if (!Model.usuario.getSession()) {
  //   window.location.href = "/login"
  // }

  return (
    <Page>
      {/* <div style={
        {
          // minHeight: "100vh",
          // backgroundImage: "url('/img/rojoo.jpg')",
          // backgroundRepeat: "no-repeat",
          // backgroundZide: "cover",
          // backgroundPosition: "center",
          // backgroundAttachment: "fixed",
          // position: "absolute"
        }
      }> */}


      {/* <h1> <Button>Club Deportivo Guabirá</Button></h1> */}



      <Box sx={{ display: 'flex', gap: 28, alignItems: 'center', flexWrap: 'wrap' }}>
        {item({
          to: "/perfil",
          name: "Perfil",
          img: "/img/ajustes.png"
        })}
        {item({
          to: "/usuario",
          name: "Usuarios",
          // img: "2256990.png",
          img: "/img/usuarios.png"
        })}
        {item({
          to: "/evento",
          name: "evento",
          img: "120.png"
        })}
        {item({
          to: "/venta",
          name: "venta",
          img: "55.png"
        })}
        {/* {item({
          to: "sector",
          name: "sector",
          img: "100.png"
        })} */}
        {/* {item({
          to: "ticket",
          name: "ticket",
          img: "55.png"
        })} */}
        {/* {item({
          to: "venta",
          name: "venta",
          img: "22.png"
        })} */}
        {/* {item({
          to: "orden_pago",
          name: "orden_pago",
          img: "125.png"
        })} */}
      </Box>

      {/* </div> */}

    </Page>
  );
}
