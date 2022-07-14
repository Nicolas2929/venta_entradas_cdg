import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../Components/Page';

export default function Home() {
  const navigate = useNavigate();

  return (
    <Page>
      <h1>Inicio</h1>
      <Link to={"usuario"}><p>usuario</p></Link>
      <Link to={"evento"}><p>evento</p></Link>
      <Link to={"sector"}><p>sector</p></Link>
      <Link to={"ticket"}><p>ticket</p></Link>
      <Link to={"venta"}><p>venta</p></Link>
      <Link to={"orden_pago"}><p>orden_pago</p></Link>
    </Page>
  );
}
