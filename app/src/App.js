import * as React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Routes
} from 'react-router-dom';


import Home from './Pages/Home';
import Login from './Pages/Login';
import Test from './Pages/Test';
import Recibo from './Pages/Recibo';

import usuario from './Pages/usuario';
import evento from './Pages/evento';
import sector from './Pages/sector';
import ticket from './Pages/ticket';
import venta from './Pages/venta';
import orden_pago from './Pages/orden_pago';
import Perfil from './Pages/Perfil';
import admin from './Pages/admin';
import "./App.css"
import Registro from './Pages/Registro';
import Addcar from './Pages/Addcar';
import Carrito from './Pages/carrito';
import Compra from './Pages/compra';
import QR from './Pages/QR';
export default function App() {
  return (
    <Router>
      <Routes>
        <Route path='/' element={<Home />} />
        <Route path='login' element={<Login />} />
        <Route path='registro' element={<Registro />} />
        <Route path='test' element={<Test />} />
        <Route path='perfil' element={<Perfil />} />
        <Route path='recibo' element={<Recibo />} />
        <Route path='addcar/:key' element={<Addcar/>} />
        <Route path='carrito' element={<Carrito/>} />
        <Route path='compra' element={<Compra/>} />
        <Route path='qr' element={<QR/>} />
        {usuario}
        {evento}
        {sector}
        {ticket}
        {venta}
        {orden_pago}
        {admin}
      </Routes>
    </Router>
  )
}
