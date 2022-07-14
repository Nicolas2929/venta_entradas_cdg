import * as React from 'react';


export default function Titulo(props) {
    return <div>
        <p style={{
            color: "#000",
            fontWeight: "bold",
            fontSize: 20,
            textDecoration: "underline"
        }}>{props.title}</p>
        <p style={{
            color: "#000",
            fontWeight: "bold",
            fontSize: 15,
            textDecoration: "underline"
        }}>{props.subTitle}</p>

    </div>
}