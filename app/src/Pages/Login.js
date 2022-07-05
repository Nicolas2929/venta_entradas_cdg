import * as React from 'react';

import Formulario from '../Components/Formulario';
export default function Login() {
  const list_inputs = [
    "nombre",
    "apellido",
    "correo"
  ];

  return (
    <div>
      <Formulario inputs={list_inputs} onSubmit={(data) => {
        
      }} />
    </div>
  );
}
