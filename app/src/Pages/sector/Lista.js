import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import TableData from '../../Components/TableData';
import Model from '../../Model';
export default function Lista() {
    const navigate = useNavigate();
    const [state, setState] = React.useState({});

    React.useEffect(() => {
        Model.evento.getAll((resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.data) return null;
        return <TableData header={[
            "nombre", "precio", "capacidad"
        ]} data={state.data}
        />

    }
    return (
        <div>
            {getLista()}
        </div>
    );
}
