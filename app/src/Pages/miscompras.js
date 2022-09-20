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
            state.data = resp.data.map((obj) => {
                obj["Fecha"] = new Date(obj.fecha_on).toLocaleDateString();
                return obj;
            });
            state.data = state.data.sort((a, b) => new Date(b.fecha_on) - new Date(a.fecha_on));
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.data) return null;
        var usuario = Model.usuario.getSession();
        console.log(state.data);
        return <TableData header={[
            "Fecha", "nit", "razon_social", "cantidad", "total", "estado"
        ]}
            data={state.data.filter((obj) => obj.key_usuario == usuario.key && obj.estado == 2)}
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
