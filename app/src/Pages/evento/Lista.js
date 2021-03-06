import { Button, Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import AddBtn from '../../Components/AddBtn';
import Page from '../../Components/Page';
import TableData from '../../Components/TableData';
import Model from '../../Model';
export default function Lista() {
    const navigate = useNavigate();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.evento.getAll((resp) => {
            state.data = resp.data;
            state.data.sort((a, b) => {
                var fecha_a = new Date(a.fecha + " " + a.hora);
                var fecha_b = new Date(b.fecha + " " + b.hora);
                return fecha_a.getTime() < fecha_b.getTime() ? 1 : -1
            })
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.data) return null;
        return <TableData header={[
            "descripcion", "fecha", "hora",
        ]} data={state.data}
            filter={obj => obj.estado != 0}
            onSelect={(itm) => {
                navigate("/evento/perfil/" + itm.key)

            }}
        />

    }
    return (
        <Page>

            <Typography variant="h5">
                Eventos
                <AddBtn onClick={() => {
                    navigate("/evento/registro")
                }} />
            </Typography>
            {getLista()}
        </Page>


    );
}
