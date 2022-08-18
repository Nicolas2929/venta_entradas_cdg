import React from 'react';
import { Button, ButtonGroup, Grid, TextField } from '@mui/material';
import TableData from '../TableData';
// ...other imports

const VentaItem = (props) => {
    var { data } = props;
    if (!data) return null;

    const getDetalle = () => {

        return <>
            <TableData header={[
                 "descripcion", "precio",
            ]}
                data={data.detalle}
                onSelect={(itm) => {
                    // navigate("/qr/" + itm.key)
                }}
            />

        </>

    }

    const getEstado = (estado) => {
        switch (estado) {
            case 1:
                return "Pendiente de pago";
            case 2:
                return "Pagado";
            default:
                return estado;
        }
    }
    return (
        <div>
            <Grid container >
                <Grid item xs={6}>
                    nit: {data.nit}
                    <br />
                    razon social: {data["razon_social"]}
                    {/* <Button variant="contained" color='error' ></Button> */}

                </Grid>
                <Grid item xs={6}>
                    Estado:
                    <Button variant="contained" color='error'> {getEstado(data["estado"])}</Button>
                </Grid>
            </Grid>
            <ButtonGroup orientation='vertical'>
            </ButtonGroup>
            {getDetalle()}
            <br />
            <Grid container >
                <Grid xs={12} item style={{
                    textAlign: "end"
                }}>
                    TOTAL: <Button variant="contained" color='error'> Bs.{data.total}</Button>
                </Grid>
            </Grid>


        </div>
    );
};

export default VentaItem;