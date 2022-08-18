import * as React from 'react';
import { AppBar, Button, Link } from '@mui/material';
import "./index.css"
import { ClassNames } from '@emotion/react';
import Model from '../../Model';
export default function TopBar(props) {
    const btnMenu = (data) => {
        return <div className='btnMenu'>
            <Link href={data.href} variant='button'>
                {data.label}
            </Link>
        </div>

    }

    var usuario = Model.usuario.getSession();
    if (!usuario) {
        window.location.href = "/login"
    }
    if (!usuario.admin) {
        window.location.href = "/"  
    }
    return <>
        <AppBar position="stickey" style={{ backgroundColor: "#fff", color: "black" }}>
            <div style={{
                // justifyContent:"center",
                display: "flex",
                alignItems: "center"
            }}>
                <a href={"/"}>
                    <img src={"/img/logo.png"} width={50} />
                </a>
                {btnMenu({ label: "home", href: "/admin" })}
                {btnMenu({ label: "My Perfil", href: "/perfil" })}
                {btnMenu({ label: "usuario", href: "/usuario" })}
                {btnMenu({ label: "evento", href: "/evento" })}
                {btnMenu({ label: "venta", href: "/venta" })}
                {btnMenu({ label: "reportes", href: "/report" })}
                {/* {btnMenu({ label: "ticket", href: "/ticket" })} */}
                {/* {btnMenu({ label: "venta", href: "/venta" })} */}
                {/* {btnMenu({ label: "orden_pago", href: "/orden_pago" })} */}
            </div>

        </AppBar>
    </>
}