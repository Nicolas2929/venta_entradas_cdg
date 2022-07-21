import { Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import Formulario from '../../Components/Formulario';
import Page from '../../Components/Page';
import Model from '../../Model';
export default function Registro() {
    const navigate = useNavigate();
    return (
        <Page>
            <Typography variant="h5">
                Nuevo Usuario
            </Typography>
            <Formulario inputs={["nombre", "apellido", "correo", "telefono", "password", "admin"]} onSubmit={(data) => {
                Model.usuario.registro(data, (resp) => {
                    if (resp.estado == "exito") {
                        window.history.back()
                    } else {
                        console.log(resp)
                        alert(resp.error)
                    }
                })
            }} />
        </Page>

    );
}
