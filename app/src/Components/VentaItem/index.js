import React from 'react';
import { Button, TextField } from '@mui/material';
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
            <Button variant="outlined">nit: {data.nit}</Button>
            <p><Button variant="outlined">razon social: {data["razon_social"]}</Button></p>
            {/* <p>cantidad: {data["cantidad"]}</p> */}
            <p><Button variant="outlined">total: Bs.{data["total"]}</Button></p>
            <p><Button variant="outlined">estado {data["estado"]}</Button></p>
            {getDetalle()}


        </div>
    );
};

export default VentaItem;