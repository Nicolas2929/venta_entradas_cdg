import * as React from 'react';
import { Button } from '@mui/material';
import "./index.css"
export default function TopBar(props) {
    const btnMenu = (data) => {
        return <div className='btnMenu'>
            <a href={data.href}>
                <Button variant="contained" color="inherit">
                    {data.label}
                    </Button>
            </a>
        </div>
    }
    return <div className='TopBar' >

<a href={"/"}>
        <Button color="inherit">Guabira
        </Button>
        </a>
        <br />
        {btnMenu({ label: "usuario", href: "/usuario" })}
        {btnMenu({ label: "evento", href: "/evento" })}
        {btnMenu({ label: "sector", href: "/sector" })}
        {btnMenu({ label: "ticket", href: "/ticket" })}
        {btnMenu({ label: "venta", href: "/venta" })}
        {btnMenu({ label: "orden_pago", href: "/orden_pago" })}

    </div>
}