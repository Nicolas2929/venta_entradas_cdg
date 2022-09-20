import { Button, Grid, Input, InputAdornment, TextField } from '@mui/material';
import * as React from 'react';
import { useParams } from 'react-router-dom';
import Page from '../Components/Page';
import VentaItem from '../Components/VentaItem';
import Http from '../Http';
import Model from '../Model';




export default function Recibo(props) {
  const { key } = useParams();
  const [state, setState] = React.useState({
  });

  React.useEffect(() => {
    // Http.QRAPI("prueba primer qr", (resp) => {
    //     console.log(resp);
    // })
    Http.QRAPI2(Http.URL_PAGE + "/recibo/" + key, (resp) => {
      state.qr = resp.data;
      setState({ ...state });
    })
    Model.venta.getByKey(key, (resp) => {
      state.data = resp.data;
      Model.usuario.getByKey(resp.data.key_usuario, (resp) => {
        state.data.usuario = resp.data;
        setState({ ...state });
      })
    })
  }, [])

  return <Page nouser >
    <br/>
    <Grid textAlign={"center"}>
      <img src={"data:image/jpeg;base64, " + state.qr?.b64} width={300} />

    </Grid>
    <VentaItem data={state.data} />

  </Page>
}