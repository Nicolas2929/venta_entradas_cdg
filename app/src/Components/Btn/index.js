import * as React from 'react';
import Button from '@mui/material/Button';

export default function Btn(props) {
    return (
        <Button onClick={props.onClick} variant="outlined">{props.children}</Button>
    );

}