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
import Miscompras from './Pages/miscompras';
import QR from './Pages/QR';
import Landing from './Pages/landing/landing';
import ConfirmarPago from './Pages/confirmarPago';
import report from './Pages/report';
export default function App() {
  return (
    <Router>
      <Routes>
        <Route path='/' element={<Landing />} />
        <Route path='home' element={<Home />} />
        <Route path='login' element={<Login />} />
        <Route path='registro' element={<Registro />} />
        <Route path='test' element={<Test />} />
        <Route path='perfil' element={<Perfil />} />
        <Route path='recibo/:key' element={<Recibo />} />
        <Route path='addcar/:key' element={<Addcar />} />
        <Route path='carrito' element={<Carrito />} />
        <Route path='compra' element={<Compra />} />
        <Route path='miscompras' element={<Miscompras />} />
        <Route path='qr/:key' element={<QR />} />
        <Route path='confirmar_pago/:key' element={<ConfirmarPago />} />
        {usuario}
        {evento}
        {sector}
        {ticket}
        {venta}
        {orden_pago}
        {admin}
        {report}
      </Routes>
    </Router>
  )
}
