import * as React from 'react';

import "./index.css"
export default function TopBar(props) {
    const btnMenu = (data) => {
        return <div className='btnMenu'>
            <a href={data.href}>{data.label}</a>
        </div>
    }
    return <div className='TopBar' >
        <label>Guabira</label>
        <br />
        {btnMenu({ label: "usuario", href: "/usuario" })}
        {btnMenu({ label: "evento", href: "/evento" })}
        {btnMenu({ label: "sector", href: "/sector" })}
        {btnMenu({ label: "ticket", href: "/ticket" })}

    </div>
}