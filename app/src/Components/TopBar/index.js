import * as React from 'react';
import { AppBar, Button } from '@mui/material';
import "./index.css"
import { ClassNames } from '@emotion/react';
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
    return <AppBar position="stickey" style={{backgroundColor: "red",color: "black"}}>
<a href={"/"}>
       GUABIRA
       
        </a>
        <br />
        <div>
            {btnMenu({ label: "usuario", href: "/usuario" })}
        {btnMenu({ label: "evento", href: "/evento" })}
        {btnMenu({ label: "sector", href: "/sector" })}
        {btnMenu({ label: "ticket", href: "/ticket" })}
        {btnMenu({ label: "venta", href: "/venta" })}
        {btnMenu({ label: "orden_pago", href: "/orden_pago" })}
        </div>
        
 </AppBar>
}