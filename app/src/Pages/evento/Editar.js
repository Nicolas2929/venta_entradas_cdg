import { Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom'
import Btn from '../../Components/Btn';
import DeleteBtn from '../../Components/DeleteBtn';
import Formulario from '../../Components/Formulario';
import Page from '../../Components/Page';
import Model from '../../Model';

export default function Editar() {
    const navigate = useNavigate();
    const { key } = useParams();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.evento.getByKey(key, (resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])
    if (!state.data) return "cargando"
    return (
        <Page>
            <Typography variant="h5">
                Editar Evento
                <DeleteBtn onClick={() => {
                    Model.evento.editar({
                        ...state.data,
                        estado: 0,
                    }, (resp) => {
                        if (resp.estado == "exito") {
                            navigate("/evento")
                        } else {
                            console.log(resp)
                        }
                    })
                }} />
            </Typography>
            <Formulario
                inputs={["descripcion", "fecha", "hora"]}
                defaultValue={state.data}
                onSubmit={(data) => {
                    Model.evento.editar({
                        ...state.data,
                        ...data
                    }, (resp) => {
                        if (resp.estado == "exito") {
                            window.history.back()
                        } else {
                            console.log(resp)
                        }
                    })
                }} />
        </Page>
    );
}
