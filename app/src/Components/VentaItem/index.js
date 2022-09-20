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
        <div style={{
            textAlign: "center"
        }}>
            <Grid item xs={6}>
                <Button variant="contained" color='error'> {getEstado(data["estado"])}</Button>
            </Grid>
            <br />
            <Grid container >
                <Grid item xs={6} style={{
                    textAlign: "start"
                }}>
                    <span>Nombre: <b>{data?.usuario["nombre"]} {data?.usuario["apellido"]}</b></span>
                    <br />
                    <span>Telefono: <b>{data?.usuario["telefono"]}</b></span>
                    <br />
                    <span>Correo: <b>{data?.usuario["correo"]}</b></span>
                    <br />
                </Grid>
                <Grid item xs={6} style={{
                    textAlign: "end"
                }}>
                    Fecha:{"\t"} {new Date(data.fecha_on).toLocaleDateString()}
                    <br />
                    nit:{"\t"} <b>{data.nit}</b>
                    <br />
                    razon social:{"\t"} <b>{data["razon_social"]}</b>
                    {/* <Button variant="contained" color='error' ></Button> */}

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