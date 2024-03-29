import React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';


export default function TableData(props) {
    const { data, header } = props;


    var rows = data;
    if (props.filter) {
        rows = data.filter(props.filter);
    }

    const renderData = (data) => {
        var resp = data;
        if (typeof data == "object") {
            resp  = JSON.stringify(data);
        }
        return resp;
    }
    return (
        <TableContainer component={Paper}>
            <Table aria-label="simple table">
                <TableHead>
                    <TableRow>
                        {header.map((h) => (
                            <TableCell component="th" scope="row">{h}</TableCell>
                        ))}
                    </TableRow>
                </TableHead>
                <TableBody>
                    {rows.map((row) => (
                        <TableRow onClick={() => {
                            if (!props.onSelect) return;
                            props.onSelect(row)
                        }} >
                            {header.map((h) => (
                                <TableCell component="th" scope="row">{renderData(row[h])}</TableCell>
                            ))}
                        </TableRow>
                    ))}

                </TableBody>
            </Table>
        </TableContainer>
    );
}