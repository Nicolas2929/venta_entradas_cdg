import { Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom'
import Formulario from '../../Components/Formulario';
import Page from '../../Components/Page';
import Model from '../../Model';

export default function Editar() {
    const navigate = useNavigate();
    const { key } = useParams();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.sector.getByKey(key, (resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])
    if (!state.data) return "cargando"
    return (
        <Page>
            <Typography variant="h5">
                Editar Sector
            </Typography>
            <Formulario
                inputs={["nombre", "precio", "capacidad"]}
                defaultValue={state.data}
                onSubmit={(data) => {
                    Model.sector.editar({
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
