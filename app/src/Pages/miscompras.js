import { Button, Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import Page from '../Components/Page';
import TableData from '../Components/TableData';
import Model from '../Model';
export default function Miscompras() {
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
        var usuario = Model.usuario.getSession();
        console.log(state.data);
        return <TableData header={[
            "codigo", "nit", "razon_social", "codigo", "cantidad", "total", "estado"
        ]}
            data={state.data.filter((obj) => obj.key_usuario == usuario.key)}
            onSelect={(itm) => {
                switch (itm.estado) {
                    case 1:
                        navigate("/qr/" + itm.key)
                        return;
                    case 2:
                        navigate("/recibo/" + itm.key)
                        return;

                }
            }}
        />

    }
    return (
        <Page nouser >
            <Typography variant="h5">
                Mis compras
            </Typography>
            {getLista()}
        </Page>
    );
}
