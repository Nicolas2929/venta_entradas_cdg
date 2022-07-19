import { Button } from '@mui/material';
import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import Page from '../../Components/Page';
import TableData from '../../Components/TableData';
import Model from '../../Model';
export default function Lista() {
    const navigate = useNavigate();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.evento.getAll((resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.data) return null;
        return <TableData header={[
            "hora", "fecha", "descripcion"
        ]} data={state.data}
            onSelect={(itm) => {
                navigate("/evento/perfil/"+itm.key)

            }}
        />

    }
    return (
        <Page>
            {getLista()}
            <Button variant="outlined" color="error" onClick={() => {
                navigate("/evento/registro")

            }}>
                registar
            </Button>
        </Page>


    );
}
