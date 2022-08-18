import { Box } from '@mui/material';
import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../../Components/Page';

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

  return (
    <Page>

      <Box sx={{ display: 'flex', gap: 28, alignItems: 'center', flexWrap: 'wrap' }}>
        {item({
          to: "/report/view_venta_detalle",
          name: "view_venta_detalle",
          img: "/img/ajustes.png"
        })}
        {item({
          to: "/report/ventas_por_sector",
          name: "ventas_por_sector",
          img: "/img/ajustes.png"
        })}
    
      </Box>

      {/* </div> */}

    </Page>
  );
}
