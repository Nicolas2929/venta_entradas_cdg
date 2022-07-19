import * as React from 'react';
import Button from '@mui/material/Button';
import EditIcon from '@mui/icons-material/Edit';

export default function EditBtn(props) {
    return (
        <Button onClick={props.onClick} variant="text"><EditIcon/>{props.children}</Button>
    );

}