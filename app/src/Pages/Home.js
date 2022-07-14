import { width } from '@mui/system';
import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../Components/Page';

export default function Home() {
  const navigate = useNavigate();

  return (
    <Page>
      <h2>Guabira</h2>
      <Link to={"usuario"}>
        <div><img style={{height:"60px", width:"60px"}} alt="" src='2256990.png' /></div>
        <div><button>usuario</button></div>
      </Link>
      <Link to={"evento"}> <div><img style={{height:"60px", width:"60px"}} alt="" src='65656.jpg' /></div>
        <div><button>evento</button></div>
        </Link>
      <Link to={"sector"}>
      <div><img style={{height:"60px", width:"60px"}} alt="" src='11926.jpg' /></div>
        <div><button>sector</button></div>
        </Link>
      <Link to={"ticket"}>
      <div><img style={{height:"60px", width:"60px"}} alt="" src='1.jpg' /></div>
        <div><button>ticket</button></div>
        </Link>
      <Link to={"venta"}>
      <div><img style={{height:"60px", width:"60px"}} alt="" src='2.jpg' /></div>
        <div><button>venta</button></div>
        </Link>
      <Link to={"orden_pago"}>
      <div><img style={{height:"60px", width:"60px"}} alt="" src='4.png' /></div>
        <div><button>orden_pago</button></div>
        </Link>
      
    </Page>
  );
}
