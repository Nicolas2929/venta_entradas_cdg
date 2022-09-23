import React, { Component } from 'react';
import { Avatar, Box, Card, CardContent, CardHeader, Container, Divider, Grid, List, ListItem, ListItemAvatar, ListItemText, Typography } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import AddCarDialog from './AddCarDialog';
export default function EventoItem(props) {
    const navigate = useNavigate();
    var { obj, state } = props;
    if (obj.estado != 1) return null;
    var sectores = state.sectores.filter(itm => itm.key_evento == obj.key);
    var min = 0;
    sectores = sectores.sort((a, b) => b.precio - a.precio)
    sectores.map(sec => {
        if (!min) {
            min = sec.precio;
            return;
        }
        if (min > sec.precio) {
            min = sec.precio;
        }
    })
    return <>
        <Grid
            item
            xs={12}
            md={4}
        >
            <Card style={{
                border: "2px solid #ff000066"
            }}>
                <CardHeader
                    title={obj.descripcion}
                    subheader={obj.fecha}
                    titleTypographyProps={{ align: 'center' }}
                    subheaderTypographyProps={{
                        align: 'center',
                    }}

                />
                <CardContent>
                    <Box
                        sx={{
                            display: 'flex',
                            justifyContent: 'center',
                            alignItems: 'baseline',
                            mb: 2,
                        }}
                    >
                        <Typography variant="h6" color="text.secondary">
                            Bs.
                        </Typography>
                        <Typography component="h2" variant="h3" color="text.primary">
                            {min}
                        </Typography>

                    </Box>
                    <ul>
                        {sectores.map((sec) => (
                            <Typography
                                component="li"
                                variant="subtitle1"
                                style={{
                                    marginTop: 16
                                }}


                            >
                                {sec.nombre}
                                {/* <br /> */}
                                {/* <span style={{
                                    fontSize:10
                                }}>Disponibles {sec.capacidad - sec.vendidas}</span> */}


                                <AddCarDialog evento={obj} sector={sec}>
                                    <span style={{
                                        background: "#F00000",
                                        cursor: "pointer",
                                        padding: 3,
                                        marginLeft: 10,
                                        borderRadius: 15,

                                        color: "#fff"
                                    }}
                                    // onClick={() => {
                                    //     navigate("addcar/" + sec.key);
                                    // }}
                                    >
                                        Bs.{sec.precio}
                                    </span>
                                </AddCarDialog>

                            </Typography>
                        ))}
                    </ul>

                </CardContent>

            </Card>
        </Grid>
        <br />
    </>

}
