import { Button, Typography } from '@mui/material';
import * as React from 'react';
import { useNavigate, useParams } from 'react-router-dom'
import Page from '../../Components/Page';
import TableData from '../../Components/TableData';
import Model from '../../Model';
export default function index() {
    const navigate = useNavigate();
    const [state, setState] = React.useState({});
    const { key } = useParams();
    if (!key) {
        window.location.href = ""
    }
    React.useEffect(() => {
        Model.report.getAll(key, (resp) => {
            state.data = resp.data;
            setState({ ...state });
        })
    }, [])
    const getLista = () => {
        if (!state.data) return null;
        if (state.data.length <= 0) {
            return <Typography>No data</Typography>
        }
        var header = Object.keys(state.data[0] ?? {});
        return <TableData header={header} data={state.data}
        />

    }
    return (
        <Page>
            <br/>
            <Typography variant="h5">
                {key.replace(/\_/g," ").toUpperCase()}
            </Typography>
            <hr/>
            {getLista()}
        </Page>
    );
}
