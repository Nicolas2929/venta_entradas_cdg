import { Avatar, Box, Divider, List, ListItem, ListItemAvatar, ListItemText } from '@mui/material';
import { width } from '@mui/system';
import * as React from 'react';
import { Link, useNavigate } from 'react-router-dom'
import Page from '../Components/Page';
import Button from '@mui/material/Button';
import Model from '../Model';

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
      state.eventos = state.eventos.filter(a => new Date(a.fecha + " " + a.hora).getTime() > new Date().getTime())
      setState({ ...state });
    })
    Model.sector.getAll((resp) => {
      state.sectores = resp.data;
      setState({ ...state });
    })
  }, [])

  const getAdmin = () => {
    var usuario = Model.usuario.getSession();
    if (!usuario.admin) return null;
    return <Button onClick={() => {
      window.location.href = "/admin"
    }}>Admin</Button>
  }

  const getSectoresItem = (obj, sectores) => {
    return (<div>
      {sectores.map((itm) => {
        return <div onClick={()=>{
          console.log(itm)
        }}>
          {itm.nombre} - Bs. {itm.precio}
        </div>
      })}
    </div>)
  }
  const EventoItem = (obj) => {
    if (obj.estado != 1) return;
    var sectores = state.sectores.filter(itm => itm.key_evento == obj.key);
    return <>
      <ListItem alignItems="flex-start">
        <ListItemAvatar>
          <Avatar alt={obj.descripcion} src="/img/" />
        </ListItemAvatar>
        <ListItemText
          primary={obj.descripcion}
          secondary={<>
            {obj.fecha + " " + obj.hora}
            <hr color='#eee' />
            {getSectoresItem(obj, sectores)}
          </>}
        />
        {/* <Button onClick={() => {
          alert(obj.descripcion);
        }}>Asistir</Button> */}
      </ListItem>
      <Divider variant="inset" component="li" />
    </>
  }
  const getListaEvento = () => {
    if (!state.eventos) return null
    if (!state.sectores) return null

    return <List sx={{ width: '100%', maxWidth: 400, }} >
      {state.eventos.map((obj) => {
        return EventoItem(obj)
      })}
    </List>
  }
  return (
    <Page hidden>
      <Button onClick={() => {
        window.location.href = "/perfil"
      }}>Perfil</Button>
      {getAdmin()}
      <hr />
      {getListaEvento()}
    </Page>
  );
}
