import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import { useParams } from 'react-router-dom';
import Page from '../Components/Page';
import TopBar from '../Components/TopBar';
import Model from '../Model';




export default function Compra(props) {
    const [state, setState] = React.useState({
    });

    React.useEffect(() => {

    }, [])


    const getTotal = () => {
        var detalle = Model.carrito.getAll();

        if (!detalle) return null;
        var total = 0;
        Object.values(detalle).map((obj) => {
            total += obj.precio * obj.cantidad;
        });
        return <div>
            <Grid container spacing={1}>
                <Grid item xs={6}>
                </Grid>
                <Grid item xs={2}>
                </Grid>
                <Grid item xs={2}>
                </Grid>
                <Grid item xs={2}>
                    <TextField id="in_total_total" label="Total" variant="outlined" value={total} type={"number"} />
                </Grid>

            </Grid>
            <br />
        </div >
    }
    const getDetalle = () => {
        var detalle = Model.carrito.getAll();

        if (!detalle) return null;
        return Object.values(detalle).map((obj) => {
            console.log(obj)
            return <div>
                <Grid container spacing={1}>

                    <Grid item xs={6}>
                        <TextField fullWidth id="in_nombre" label="Sector" variant="outlined" value={obj.detalle} />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField id="in_precio" label="Precio" variant="outlined" value={obj.precio} />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField id="in_cantidad" label="Cantidad" variant="outlined" value={obj.cantidad} type={"number"} onChange={(evt) => {

                        }} />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField id="in_total" label="Sub-Total" variant="outlined" value={obj.precio * obj.cantidad} type={"number"} />
                    </Grid>

                </Grid>
                <br />
            </div >
        })
    }
    return <Page nouser >

        <h1>Detalle de la compra</h1>
        <Grid container spacing={1}>
            <Grid item xs={8}>
                <TextField id="in_precio" label="Nit" variant="outlined" />
            </Grid>
            <Grid item xs={4}>
                <TextField fullWidth id="in_nombre" label="Fecha" variant="outlined" value={new Date().toDateString()} />
            </Grid>
            <Grid item xs={6}>
                <TextField fullWidth id="in_nombre" label="Razon Social" variant="outlined" />
            </Grid>
        </Grid>
        <br /> <hr /> <br />
        {getDetalle()}
        {getTotal()}

        <Button onClick={() => {
            window.location.href = "/qr"
        }} color={"error"} variant={"contained"}>GENERAR QR</Button>
    </Page>
}