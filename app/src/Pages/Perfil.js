import { Button, TextField } from '@mui/material';
import * as React from 'react';
import Page from '../Components/Page';
import Model from '../Model';
import { Typography } from '@mui/material';



export default function Perfil(props) {
    var usuario = Model.usuario.getSession()
    if (!usuario) {
        window.location.href = "/login"
    }

    return <Page hidden>
        <Typography variant="h5">
                Perfil usuario
            </Typography>
            
                
        <br/><p> 
        <label><Button variant="contained" color='primary'fullWidth>key: {usuario.key}</Button></label>
        <br /></p>
        <label><Button variant="contained" color='primary'fullWidth>nombre: {usuario.nombre}</Button></label>
        <br /><p>
        <label><Button variant="contained" color='primary'fullWidth>apellido: {usuario.apellido}</Button></label>
        <br /></p>
        <label><Button variant="contained" color='primary'fullWidth>correo: {usuario.correo}</Button></label>
        <br /><p>
        <label><Button variant="contained" color='primary'fullWidth>telefono: {usuario.telefono}</Button></label>
        <br /></p>
        <label><Button variant="contained" color='primary'fullWidth>password: {usuario.password}</Button></label>
        <br /><p>
        <label><Button variant="contained" color='primary'fullWidth>ci: {usuario.ci}</Button></label>
        <br /></p>
        <label><Button variant="contained" color='primary'fullWidth>admin: {usuario.admin?"SI":"NO"}</Button></label>
        <br /><p>
        <Button variant="contained" color='error' onClick={() => {
            Model.usuario.cerrarSession();
        }}>cerrar session</Button>
        </p>
    </Page>
}