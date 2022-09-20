import { Button, Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom'
import AddBtn from '../../Components/AddBtn';
import EditBtn from '../../Components/EditBtn';
import Formulario from '../../Components/Formulario';
import Page from '../../Components/Page';
import TableData from '../../Components/TableData';
import Model from '../../Model';

export default function Perfil() {
    const navigate = useNavigate();
    const { key } = useParams();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.evento.getByKey(key, (resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
        Model.sector.getByKeyEvento(key, (resp) => {
            state.vendidas = 0;
            state.total = 0;
            state.eventos = resp.data.map((obj) => {
                state.vendidas += obj.vendidas ?? 0;
                obj.total = obj.precio * (obj.vendidas ?? 0)
                state.total += obj.total;
                obj.total = "Bs. " + obj.total;
                obj.vendidas = "(" + obj.vendidas + "/" + obj.capacidad + ")"
                return obj;
            })
            setState({ ...state });
        })
    }, [])

    const getPerfil = () => {
        if (!state.data) return null;
        if (!state.eventos) return null;

        return <div>
            <Typography variant="h5">
                Evento
                <EditBtn onClick={() => {
                    navigate("/evento/editar/" + key)
                }} />
            </Typography>
            <p><button>{state.data.descripcion}</button></p>
            <p><button>{state.data.hora}</button></p>
            <p><button>{state.data.fecha}</button></p>


            <hr />
            <Typography variant="h5">
                Sectores
                <AddBtn onClick={() => {
                    navigate("/sector/registro/" + key)
                }} />
            </Typography>
            <h3>Total: Bs. {state?.total}</h3>
            <h3># Vendidas: ({state?.vendidas})</h3>
            <TableData header={[
                "nombre", "precio", "vendidas", "total"
            ]}
                data={state.eventos}
                onSelect={(itm) => {
                    navigate("/sector/editar/" + itm.key)

                }}
            />


        </div>
    }

    return (
        <Page>
            {getPerfil()}
        </Page>
    );
}
