import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Page from '../Components/Page';
import VentaItem from '../Components/VentaItem';
import Http from '../Http';
import Model from '../Model';




export default function QR(props) {
    const { key } = useParams();
    const navigate = useNavigate();
    const [state, setState] = React.useState({
    });

    React.useEffect(() => {
        Http.QRAPI(Http.URL_PAGE + "/confirmar_pago/" + key, (resp) => {
            state.qr = resp.data;
            setState({ ...state });
        })
        Model.venta.getByKey(key, (resp) => {
            state.data = resp.data;
            if (state.data.estado == 2) {
                navigate("/recibo/" + key)
            }
            Model.usuario.getByKey(resp.data.key_usuario, (resp) => {
                state.data.usuario = resp.data;
                setState({ ...state });
            })
        })

    }, [])

    return <Page nouser >
        <Grid textAlign={"center"}>
            <h2>Escanea el Codigo QR con tu app el banco</h2>
            <img src={"data:image/jpeg;base64, " + state.qr?.b64} width={300} />

        </Grid>
        <h2>Detalle</h2>
        <VentaItem data={state.data} />


    </Page>
}