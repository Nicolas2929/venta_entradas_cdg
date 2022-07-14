import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import Formulario from '../../Components/Formulario';
import Page from '../../Components/Page';
import Model from '../../Model';
export default function Registro() {
    const navigate = useNavigate();
    return (
        <Page>
            <Formulario inputs={["nombre", "apellido", "correo", "telefono", "password"]} onSubmit={(data) => {
                Model.usuario.registro(data, (resp) => {
                    window.history.back()
                })
            }} />
        </Page>
    );
}
