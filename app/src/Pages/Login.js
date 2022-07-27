

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
import Page from '../Components/Page';


const theme = createTheme();

export default function Login() {
  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    Model.usuario.login({
      correo: data.get("email"),
      password: data.get("password")
    }, (resp) => {
      if (resp.estado == "exito") {
        if (resp?.data?.admin) {
          window.location.href = "/admin"
        } else {
          window.location.href = "/"
        }
      } else {
        alert(resp.error)
      }
    })
  };

  if (Model.usuario.getSession()) {
    window.location.href = "/"
  }

  return (
    <Page nouser>
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
              Inicia sesión
            </Typography>
            <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
              <TextField
                margin="normal"
                error
                fullWidth
                id="email"
                label="Correo"
                name="email"
                autoComplete="email"
                autoFocus
              />
              <TextField
                margin="normal"
                error
                fullWidth
                name="password"
                label="Contraseña"
                type="password"
                id="password"
                autoComplete="current-password"
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
                Iniciar
              </Button>
              <Grid container>
                <Grid item xs>
                  {/* <Link href="#" variant="body2" color="error">
                  Forgot password?
                </Link> */}
                </Grid>
                <Grid item>
                  <Link href="/registro" variant="body2" color="error">
                    {"No tienes usuario? Registrate"}
                  </Link>
                </Grid>
              </Grid>
            </Box>
          </Box>
        </Container>
      </ThemeProvider>
    </Page>
  );
}