import { Container } from '@mui/material';
import * as React from 'react';
import TopBar from '../TopBar';
export default function Page(props) {
    return <div>
        <TopBar />
        <Container >
            {props.children}

        </Container>
    </div>
}