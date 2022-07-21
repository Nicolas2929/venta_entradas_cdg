import { Button } from '@mui/material';
import * as React from 'react';
import Page from '../Components/Page';
import Model from '../Model';


export default function Perfil(props) {
    var usuario = Model.usuario.getSession()
    if (!usuario) {
        window.location.href = "/login"
    }

    return <Page hidden>
        <br/>
        <label>key: {usuario.key}</label>
        <br />
        <label>nombre: {usuario.nombre}</label>
        <br />
        <label>apellido: {usuario.apellido}</label>
        <br />
        <label>correo: {usuario.correo}</label>
        <br />
        <label>telefono: {usuario.telefono}</label>
        <br />
        <label>password: {usuario.password}</label>
        <br />
        <label>ci: {usuario.ci}</label>
        <br />
        <label>admin: {usuario.admin?"SI":"NO"}</label>
        <br />
        <Button onClick={() => {
            Model.usuario.cerrarSession();
        }}>cerrar session</Button>
    </Page>
}