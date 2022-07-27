import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import { Navigate, useParams } from 'react-router-dom';
import Page from '../Components/Page';
import Model from '../Model';




export default function Addcar(props) {
    const { key } = useParams();
    const [state, setState] = React.useState({
        cantidad: 1
    });

    React.useEffect(() => {
        Model.sector.getByKey(key, (resp) => {
            state.sector = resp.data;
            Model.evento.getByKey(state.sector.key_evento, (resp2) => {
                state.evento = resp2.data;
                setState({ ...state });

            })
        })
    }, [])

    const getDetalle = () => {
        if (!state.evento) return null;
        return <div>
            <hr />
            <h3>Evento</h3>
            <p>{state.evento.descripcion}</p>
            <p>{state.evento.fecha}</p>
            <hr />
            <Grid container spacing={2}>
                <Grid item xs={4}>
                    <TextField id="in_nombre" label="Sector" variant="outlined" defaultValue={state.sector.nombre} disabled />
                </Grid>
                <Grid item xs={4}>
                    <TextField id="in_precio" label="Precio" variant="outlined" defaultValue={state.sector.precio} disabled />
                </Grid>
                <Grid item xs={4}>
                    <TextField id="in_cantidad" label="Cantidad" variant="outlined" value={state.cantidad} type={"number"} onChange={(evt) => {
                        console.log(evt.target.value);
                        state.cantidad = evt.target.value;
                        if (state.cantidad <= 0) {
                            state.cantidad = 1;
                        }
                        if (state.cantidad > state.sector.capacidad) {
                            state.cantidad = state.sector.capacidad;
                        }
                        setState({ ...state });
                    }} />
                </Grid>

                <Grid item xs={8}>
                    {/* <label>Agregar al carrito</label> */}
                </Grid>
                <Grid item xs={4}>
                    <TextField id="in_total" label="Sub-Total" variant="outlined" value={state.sector.precio * state.cantidad} type={"number"} disabled />
                </Grid>
                <Grid item xs={12} >
                    <Button onClick={() => {
                        var item = {
                            key: key,
                            cantidad: parseInt(state.cantidad),
                            precio: state.sector.precio,
                            detalle:`Entradas para ${state.evento.descripcion} en el sector ${state.sector.nombre}`
                        }
                        Model.carrito.registro(item);
                        window.location.href="/carrito"
                    }}>Aceptar</Button>
                </Grid>
            </Grid>



        </div>
    }
    return <Page nouser >
        {getDetalle()}
    </Page>
}