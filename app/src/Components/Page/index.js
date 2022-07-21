import { Container } from '@mui/material';
import * as React from 'react';
import TopBar from '../TopBar';
export default function Page(props) {
    return <div>
        {!props.hidden ? <TopBar /> : null}
        <Container >
            {props.children}

        </Container>
    </div>
}