import { Avatar, Box, Card, CardContent, CardHeader, Container, Divider, Grid, List, ListItem, ListItemAvatar, ListItemText, Typography } from '@mui/material';
import { width } from '@mui/system';
import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../Components/Page';
import Button from '@mui/material/Button';
import Model from '../Model';
import TopBarCliente from '../Components/TopBarCliente';
import EventoItem from '../Components/EventoItem';

export default function Home() {
  const navigate = useNavigate();
  const [state, setState] = React.useState({});

  React.useEffect(() => {
    Model.evento.getAll((resp) => {
      state.eventos = resp.data;
      state.eventos.sort((a, b) => {
        var fecha_a = new Date(a.fecha + " " + a.hora);
        var fecha_b = new Date(b.fecha + " " + b.hora);
        return fecha_a.getTime() > fecha_b.getTime() ? 1 : -1
      })
      // state.eventos = state.eventos.filter(a => new Date(a.fecha + " " + a.hora).getTime() > new Date().getTime())
      console.log(state.eventos)

      setState({ ...state });
    })
    Model.sector.getAll((resp) => {
      state.sectores = resp.data;
      setState({ ...state });
    })
  }, [])
  const getListDetail = () => {
    if (!state.eventos) return null
    if (!state.sectores) return null
    // return <h1>{JSON.stringify(state.eventos)}</h1>
    return state.eventos.map((obj) => {
      return <EventoItem obj={obj} state={state} />
    })
  }
  const getListaEvento = () => {
    return <Container sx={{ width: '200%' }} >
      <Grid container spacing={2}>
        {getListDetail()}
      </Grid>
    </Container>
  }
  return (
    <Page nouser>
      <br />
      <br />
      <Grid container>
        {getListaEvento()}
      </Grid>
    </Page>
  );
}
