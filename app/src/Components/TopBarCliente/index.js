import * as React from 'react';
import { AppBar, Button, Link } from '@mui/material';
import "./index.css"
import { ClassNames } from '@emotion/react';
import Model from '../../Model';
export default function TopBarCliente(props) {
    const btnMenu = (data) => {
        return <div className='btnMenu'>
            <Link href={data.href} variant='button'>
                {data.label}
            </Link>
        </div>

    }

    var ITEMS = [];
    var usuario = Model.usuario.getSession();
    if (!usuario) {
        ITEMS.push(btnMenu({ label: "Login", href: "/login" }));
    } else {
        ITEMS.push(btnMenu({ label: "Perfil", href: "/perfil" }));
        ITEMS.push(btnMenu({ label: "Mis Compras", href: "/miscompras" }));
    }
    if (usuario?.admin) {
        ITEMS.push(btnMenu({ label: "Admin", href: "/admin" }));
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
                {btnMenu({ label: "Home", href: "/" })}
                {ITEMS}
                { }
                {btnMenu({ label: "Carrito", href: "/carrito" })}
                {/* {btnMenu({ label: "evento", href: "/evento" })} */}
                {/* {btnMenu({ label: "sector", href: "/sector" })} */}
                {/* {btnMenu({ label: "ticket", href: "/ticket" })} */}
                {/* {btnMenu({ label: "venta", href: "/venta" })} */}
                {/* {btnMenu({ label: "orden_pago", href: "/orden_pago" })} */}
            </div>

        </AppBar>
    </>
}