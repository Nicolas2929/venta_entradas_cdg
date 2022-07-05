import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import TableData from '../../Components/TableData';
import Model from '../../Model';
export default function Lista() {
    const navigate = useNavigate();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.usuario.getAll((resp) => {
            state.usuarios = resp.data;
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.usuarios) return null;
        return <TableData header={[
            "nombre", "apellido", "correo", "telefono", "password", "estado"
        ]} data={state.usuarios}
        />

    }
    return (
        <div>
            {getLista()}
        </div>
    );
}
