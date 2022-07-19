import { Button } from '@mui/material';
import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom'
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
            state.eventos = resp.data;
            setState({ ...state });
        })
    }, [])

    const getPerfil = () => {
        if (!state.data) return null;
        if (!state.eventos) return null;
        
        return <div>
            <p><button>{state.data.descripcion}</button></p>
            <p><button>{state.data.hora}</button></p>
            <p><button>{state.data.fecha}</button></p>
            <hr />
            <h4 color='red'><p>Sectores</p></h4>
            <Button variant="outlined" color="error" onClick={() => {
                navigate("/sector/registro/" + key)

            }}>
                Nuevo Sector
            </Button>
            <TableData header={[
                "nombre", "precio", "capacidad"
            ]} data={state.eventos}
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
