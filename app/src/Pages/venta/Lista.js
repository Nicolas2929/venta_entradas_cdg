import { Button, Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import Page from '../../Components/Page';
import TableData from '../../Components/TableData';
import Model from '../../Model';
export default function Lista() {
    const navigate = useNavigate();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.venta.getAll((resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.data) return null;
        return <TableData header={[
            "codigo", "nit", "razon_social", "codigo", "cantidad", "total"
        ]} data={state.data}
        />

    }
    return (
        <Page>
            <Typography variant="h5">
                Venta
               
            </Typography>
            {getLista()}
        </Page>
    );
}
