import { Mode } from '@mui/icons-material';
import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import { useParams } from 'react-router-dom';
import Page from '../Components/Page';
import TopBar from '../Components/TopBar';
import Model from '../Model';




export default function Carrito(props) {
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
            return <div>
                <Grid container spacing={1}>
                    <Grid item xs={1}>
                        <Button onClick={() => {
                            Model.carrito.eliminar(obj.key);
                            window.location.reload();
                        }}>X</Button>
                    </Grid>
                    <Grid item xs={5}>
                        <TextField fullWidth id="in_nombre" label="Sector" variant="outlined" value={obj.detalle} />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField id="in_precio" label="Precio" variant="outlined" value={obj.precio} />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField id="in_cantidad" label="Cantidad" variant="outlined" defaultValue={obj.cantidad} type={"number"} onChange={(evt) => {
                            var cantidad = evt.target.value;
                            if (cantidad <= 0) {
                                evt.target.value = 1;
                                return null;
                            }
                            Model.carrito.registro({
                                ...obj,
                                cantidad: cantidad
                            })
                            setState({ ...state })

                        }} />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField id="in_total" label="Sub-Total" variant="outlined" value={obj.precio * obj.cantidad} type={"number"} disabled />
                    </Grid>

                </Grid>
                <br />
            </div >
        })
    }
    return <Page nouser >

        <h1>Carrito</h1>
        {getDetalle()}
        {getTotal()}
        <Grid container>
            <Button onClick={() => {
                window.history.back();
            }} variant="contained" color="inherit">Seguir comprado</Button>
            <Grid item width={20} />
            <Button onClick={() => {
                var usuario = Model.usuario.getSession();
                if (!usuario) {
                    alert("Para realizar la compra debe iniciar sesion");
                    window.location.href = "/login";
                    return;
                }
                window.location.href = "/compra"
            }} variant="contained" color="error">Pagar</Button>
        </Grid>
    </Page>
}