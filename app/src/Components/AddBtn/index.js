import * as React from 'react';
import Button from '@mui/material/Button';
import AddCircleOutlineIcon from '@mui/icons-material/AddCircleOutline';


export default function AddBtn(props) {
    return (
        <Button onClick={props.onClick} variant="text"><AddCircleOutlineIcon/>{props.children}</Button>
    );

}