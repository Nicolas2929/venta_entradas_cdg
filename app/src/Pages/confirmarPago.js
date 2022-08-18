import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import { useParams } from 'react-router-dom';
import Page from '../Components/Page';
import VentaItem from '../Components/VentaItem';
import Http from '../Http';
import Model from '../Model';




export default function ConfirmarPago(props) {
    const { key } = useParams();
    const [state, setState] = React.useState({
    });

    React.useEffect(() => {
        // Http.QRAPI("prueba primer qr", (resp) => {
        //     console.log(resp);
        // })
        Model.venta.getByKey(key, (resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])

    return <Page nouser >

        <h1>{"CONFIRMAR PAGO"}</h1>
        <VentaItem data={state.data} />

        <Button onClick={() => {
            if (state.data.estado == 2) {
                alert("El pedido ya fue pagado, no puede pagar 2 veces.");
                window.location.href = "/recibo/" + key
                return;
            }
            state.data.estado = 2;
            Model.venta.editar(state.data, (resp) => {
                window.location.href = "/recibo/" + key

            })
        }} color={"error"} variant={"contained"}>CONFIRMAR PAGO</Button>
    </Page>
}