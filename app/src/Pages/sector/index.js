import { Route } from 'react-router-dom';
import Editar from './Editar';
import Lista from './Lista';
import Registro from './Registro';


const Name = "sector";

export default [
    <Route path={Name + ''} element={<Lista />} />,
    <Route path={Name + '/registro/:key_evento'} element={<Registro />} />,
    <Route path={Name + '/editar/:key'} element={<Editar />} />,
]