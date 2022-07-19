import * as React from 'react';
import Button from '@mui/material/Button';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
export default function DeleteBtn(props) {
    return (
        <Button onClick={() => {
            if (window.confirm("Seguro que desea eliminar?")) {
                props.onClick();
            }

        }} variant="text" color={"error"}><DeleteForeverIcon color='error' />{props.children}</Button>
    );

}