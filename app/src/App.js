import * as React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Routes
} from 'react-router-dom';


import Home from './Pages/Home';
import Login from './Pages/Login';
import Test from './Pages/Test';

import usuario from './Pages/usuario';
import evento from './Pages/evento';
import sector from './Pages/sector';
import ticket from './Pages/ticket';
import venta from './Pages/venta';
import orden_pago from './Pages/orden_pago';

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path='/' element={<Home />} />
        <Route path='login' element={<Login />} />
        <Route path='test' element={<Test />} />
        {usuario}
        {evento}
        {sector}
        {ticket}
        {venta}
        {orden_pago}
        

        
      </Routes>
    </Router>
  )
}
