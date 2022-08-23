import * as React from 'react';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import { TextField } from '@mui/material';
import Model from '../../Model';

export default function AddCarDialog(props) {
    const [open, setOpen] = React.useState(false);
    const [state, setState] = React.useState({
        cantidad: 1
    });
    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    return (
        <>
            <Button onClick={handleClickOpen} style={{float:"right"}}>
                {props.children}
            </Button>
            <Dialog
                open={open}
                onClose={handleClose}
                aria-labelledby="alert-dialog-title"
                aria-describedby="alert-dialog-description"
            >
                <DialogTitle id="alert-dialog-title">
                    {"Agregar al carrito?"}
                </DialogTitle>
                <DialogContent>
                    <DialogContentText id="alert-dialog-description">
                        {props.sector.nombre}  -  Bs.{props.sector.precio}
                    </DialogContentText>
                    <br />
                    <TextField id="in_cantidad" label="Cantidad" variant="outlined" value={state.cantidad} type={"number"} onChange={(evt) => {
                        state.cantidad = evt.target.value;
                        if (state.cantidad < 0) {
                            state.cantidad = 1;
                        }
                        if (state.cantidad > props.sector.capacidad) {
                            state.cantidad = props.sector.capacidad;
                        }
                        setState({ ...state });
                    }} />

                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Cancelar</Button>
                    <Button onClick={() => {
                        var item = {
                            key: props.sector.key,
                            cantidad: parseInt(state.cantidad),
                            precio: props.sector.precio,
                            detalle: `Entradas para ${props.evento.descripcion} en el sector ${props.sector.nombre}`
                        }
                        Model.carrito.registro(item);
                        window.location.href = "/carrito"
                        handleClose()
                    }} autoFocus>
                        Aceptar
                    </Button>
                </DialogActions>
            </Dialog>
        </>
    );
}
