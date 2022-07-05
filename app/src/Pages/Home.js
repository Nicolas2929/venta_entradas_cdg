import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
// import Model from '../Model';
export default function Home() {
  const navigate = useNavigate();

  return (
    <div>
      <h1>Inicio</h1>
      <Link to={"usuario"}><p>usuario</p></Link>
      <Link to={"evento"}><p>evento</p></Link>

    </div>
  );
}
