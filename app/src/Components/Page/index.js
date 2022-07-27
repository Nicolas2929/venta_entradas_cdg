import { Container } from '@mui/material';
import * as React from 'react';
import TopBar from '../TopBar';
import TopBarCliente from '../TopBarCliente';
export default function Page(props) {
    var barra = <TopBar />;
    if (props.nouser) {
        barra = <TopBarCliente />
    }
    return <div>
        {!props.hidden ? barra : null}
        <Container >
            {props.children}

        </Container>
    </div>
}