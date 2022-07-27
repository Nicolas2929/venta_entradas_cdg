import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import Page from '../Components/Page';
import Http from '../Http';
import Model from '../Model';




export default function QR(props) {
    const [state, setState] = React.useState({
    });

    React.useEffect(() => {
        Http.QRAPI("prueba primer qr", (resp) => {
            console.log(resp);
        })
    }, [])

    return <Page nouser >

        <h1>QR</h1>


    </Page>
}