import React from 'react';
import { Button, ButtonGroup, TextField } from '@mui/material';
import TableData from '../TableData';
// ...other imports

const VentaItem = (props) => {
    var { data } = props;
    if (!data) return null;

    const getDetalle = () => {

        return <TableData header={[
            "key", "descripcion", "precio",
        ]}
            data={data.detalle}
            onSelect={(itm) => {
                // navigate("/qr/" + itm.key)
            }}
        />

    }

    return (
        <div>
            
            <ButtonGroup  orientation='vertical'>
            <Button variant="contained"color='error' fullWidth >nit: {data.nit}</Button>
            <Button variant="contained"color='error'>razon social: {data["razon_social"]}</Button>
            {/* <p>cantidad: {data["cantidad"]}</p> */}
            <Button variant="contained"color='error'>Total: Bs.{data["total"]}</Button>
            <Button variant="contained"color='error'>Estado: {data["estado"]}</Button>
            </ButtonGroup>
            {getDetalle()}


        </div>
    );
};

export default VentaItem;