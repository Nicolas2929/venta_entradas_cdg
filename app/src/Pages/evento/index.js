import { Route } from 'react-router-dom';
import Editar from './Editar';
import Lista from './Lista';
import Perfil from './Perfil';
import Registro from './Registro';

const Name = "evento";

export default [
    <Route path={Name + ''} element={<Lista />} />,
    <Route path={Name + '/registro'} element={<Registro />} />,
    <Route path={Name + '/perfil/:key'} element={<Perfil />} />,
    <Route path={Name + '/editar/:key'} element={<Editar />} />,
]