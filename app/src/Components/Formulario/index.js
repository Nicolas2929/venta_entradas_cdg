import { TextField } from '@mui/material';
import * as React from 'react';
import Btn from "../Btn"
// props = { inputs:[] , onSubmit:Function }
export default function Formulario(props) {
    const getInputs = () => {
        return props.inputs.map((obj) => {
            return <div style={{
                padding: 4
            }}>
                <TextField id={"my-input-" + obj} placeholder={obj} label={obj} variant="outlined" />
            </div>
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
        <div>
            {getInputs()}
            <Btn onClick={submit} >Aceptar</Btn>
        </div>
    );

}