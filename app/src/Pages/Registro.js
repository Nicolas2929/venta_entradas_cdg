

import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Model from '../Model';
import { Mode } from '@mui/icons-material';


const theme = createTheme();

export default function Registro() {
  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);

    if (data.get("password") != data.get("rep_password")) {
      alert("contrasenhas diferentes");
      return;
    }
    var usuario = {
      nombre: data.get("nombre"),
      apellido: data.get("apellido"),
      correo: data.get("correo"),
      telefono: data.get("telefono"),
      password: data.get("password")
    }
    Model.usuario.registro(usuario, (resp) => {
      if (resp.estado == "exito") {
        window.location.href = "/login"
      } else {
        alert(resp.error)
      }
    })
  };

  if (Model.usuario.getSession()) {
    window.location.href = "/"
  }

  return (
    <ThemeProvider theme={theme}>
      <Container component="main" maxWidth="xs">
        <CssBaseline />
        <Box
          sx={{
            marginTop: 8,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
          }}
        >

          <Avatar src="/img/logo.png"></Avatar>
          <Typography component="h1" variant="h5">
            Registrate
          </Typography>
          <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
            <TextField
              margin="normal"
              error
              fullWidth
              id="nombre"
              label="Nombre"
              name="nombre"
              autoFocus
              required
            />
            <TextField
              margin="normal"
              error
              fullWidth
              id="apellido"
              label="Apellido"
              name="apellido"
            />
            <TextField
              margin="normal"
              error
              fullWidth
              id="correo"
              label="Correo"
              name="correo"
            />
            <TextField
              margin="normal"
              error
              fullWidth
              id="telefono"
              label="Telefono"
              name="telefono"
            />
            <TextField
              margin="normal"
              error
              fullWidth
              name="password"
              label="Contraseña"
              type="password"
              id="password"
            />
            <TextField
              margin="normal"
              error
              fullWidth
              name="rep_password"
              label="Rep. Contraseña"
              type="password"
              id="rep_password"
            />
            {/* <FormControlLabel
              control={<Checkbox value="remember" color="primary" />}
              label="Remember me"
            /> */}
            <Button
              type="submit"
              fullWidth
              variant="contained"
              color='error'
              sx={{ mt: 3, mb: 2 }}
            >
              Registrar
            </Button>

          </Box>
        </Box>
      </Container>
    </ThemeProvider>
  );
}