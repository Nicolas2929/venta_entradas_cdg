import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom'
import Formulario from '../../Components/Formulario';
import Page from '../../Components/Page';
import Model from '../../Model';
export default function Registro() {
    const { key_evento } = useParams();
    const navigate = useNavigate();
    return (
        <Page>
            <Formulario inputs={["nombre", "precio", "capacidad"]} onSubmit={(data) => {
                data.key_evento = key_evento;
                Model.sector.registro(data, (resp) => {
                    window.history.back()
                })
            }} />
        </Page>
    );
}
