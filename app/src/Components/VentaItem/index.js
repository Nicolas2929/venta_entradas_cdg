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
            <p>nit: {data.nit}</p>
            <p>razon social: {data["razon_social"]}</p>
            {/* <p>cantidad: {data["cantidad"]}</p> */}
            <p>total: Bs.{data["total"]}</p>
            <p>estado {data["estado"]}</p>
            {getDetalle()}


        </div>
    );
};

export default VentaItem;