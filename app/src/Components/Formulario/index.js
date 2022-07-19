import { Box, Grid, TextField } from '@mui/material';
import * as React from 'react';
import Btn from "../Btn"
// props = { inputs:[] , onSubmit:Function }
export default function Formulario(props) {
    const getInputs = () => {
        return props.inputs.map((obj) => {
            var defaultValue = (props?.defaultValue ?? {})[obj];
            return (
                <Grid alignItems={"center"} xs={12} style={{
                    paddingBottom: 8,
                }}>
                    <TextField id={"my-input-" + obj} placeholder={obj} label={obj} variant="outlined" defaultValue={defaultValue} style={{
                        width: "100%"
                    }} />

                </Grid>
            )
        })
    }

    const submit = () => {
        if (!props.onSubmit) return;
        const resp = {};
        props.inputs.map((obj) => {
            var input = document.getElementById("my-input-" + obj);
            resp[obj] = input.value;
        })
        props.onSubmit(resp);
    }


    return (
        <Grid container xs={12} justifyContent={"center"} >
            <Grid container justifyContent={"center"} xs={12} sm={10} md={8} lg={6} xl={4}>
                {getInputs()}
                <Btn onClick={submit} >Aceptar</Btn>
            </Grid>
        </Grid>
    );

}