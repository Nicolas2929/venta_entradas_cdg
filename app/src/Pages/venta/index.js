import { Route } from 'react-router-dom';
import Lista from './Lista';
import Registro from './Registro';


const Name = "venta";

export default [
    <Route path={Name + ''} element={<Lista />} />,
    <Route path={Name + '/registro'} element={<Registro />} />,
]