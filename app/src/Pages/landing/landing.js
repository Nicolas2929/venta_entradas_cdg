import * as React from 'react';

import "./css/bootstrap.min.css"
import "./css/style.css"
import "./css/responsive.css"
export default function index() {

    return (
        <div className="main-layout">
            <div className=" banner_main">
                <div id="myCarousel" className="carousel slide" data-ride="carousel">
                    <ol className="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" className="active"></li>
                    </ol>
                    <div className="carousel-inner">
                        <div className="carousel-item active">
                            <div className="container">
                                <div className="carousel-caption relative">
                                    <div className="bg_white">
                                        <h1>BIENVENIDOS <span className="yello">AL CLUB DEPORTIVO GUABIRÁ</span></h1>
                                        <p>Más conocido simplemente como Guabirá, es un club de fútbol de la ciudad de Montero, Departamento de Santa Cruz, Bolivia. Fue fundado el 14 de abril del 1962 por los trabajadores del Ingenio Azucarero Guabirá y actualmente participa en la Primera División de Bolivia.</p>
                                    </div>
                                    <a className="read_more ban_btn" href="/home">Adquiere tu entrada</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a className="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                        <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span className="sr-only">Previous</span>
                    </a>
                    <a className="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                        <span className="carousel-control-next-icon" aria-hidden="true"></span>
                        <span className="sr-only">Next</span>
                    </a>
                </div>
            </div>
            <div id="about" className="about top_layer">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-12">
                            <div className="titlepage">
                                <h2>ESTADIO</h2>
                                <p> </p>
                            </div>
                        </div>
                        <div className=" col-sm-12">
                            <div className="about_box">
                                <div className="row d_flex">
                                    <div className="col-md-5">
                                        <div className="about_box_text">
                                            <h3>"Gilberto Parada" de Montero</h3>
                                            <p>Conocido como “La Caldera del Diablo” es un estadio de fútbol ubicado en la ciudad de Montero, Bolivia aproximadamente a 50km de la ciudad de Santa Cruz de la Sierra forma parte de su Área Metropolitana.El mismo se encuentra a una altitud de 298 msnm.

                                                Capacidad:	18 000 espectadores
                                            </p>
                                            <a className="read_more" href="/home">Entradas</a>
                                        </div>
                                    </div>
                                    <div className=" col-md-7  pppp">
                                        <div className="about_box_img">
                                            <figure><img src="images/gilberto-parada.jpg" alt="#" /></figure>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div className="building">
                <div className="container">
                    <div className="row">
                        <div className="col-md-12">
                            <div className="titlepage">
                                <h2>MISIÓN<br /></h2>
                                <p>Trabajar para contribuir al desarrollo del fomento deportivo, mediante la formación de deportistas de alto rendimiento a nivel profesional, semi profesional y formativo, en proyección a una forma de vida, inculcando valores y principios para mantener una comunidad integra, donde la niñez y juventud sean los principales artífices.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div className="services_main">
                <div className="container">
                    <div className="row">
                        <div className="col-md-12">
                            <div className="titlepage">
                                <h2>Sponsors del Club</h2>
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-12">
                         
                            <div className="tab-content card back_bg" id="myTabContentMD">
                                <div className="tab-pane fade show active" id="home-md" role="tabpanel" aria-labelledby="home-tab-md">
                                    <div className="row">
                                        <div className="col-md-4 col-sm-6 padding_0 margin_right20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/celina.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 col-sm-6 padding_0 margin_top70p margin_right20 margin_left20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/nacional.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 col-sm-6 padding_0 margin_left20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/fancesa.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 offset-md-8 col-sm-6 padding_0 margin_top170">
                                            <div className="services margin_left60">
                                                <div className="services_img">
                                                    <figure><img src="images/grupo.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-sm-6 margin_top40">
                                            <a className="read_more " href="/home">Entradas</a>
                                        </div>
                                    </div>
                                </div>
                                <div className="tab-pane fade" id="profile-md" role="tabpanel" aria-labelledby="profile-tab-md">
                                    <div className="row">
                                        <div className="col-md-4 col-sm-6 padding_0 margin_right20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img3.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 col-sm-6 padding_0 margin_top70p margin_right20 margin_left20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img2.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 col-sm-6 padding_0 margin_left20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img4.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 offset-md-8 col-sm-6 padding_0 margin_top170">
                                            <div className="services margin_left60">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img1.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-sm-6 margin_top40">
                                            <a className="read_more " href="#">Read More</a>
                                        </div>
                                    </div>
                                </div>
                                <div className="tab-pane fade" id="contact-md" role="tabpanel" aria-labelledby="contact-tab-md">
                                    <div className="row">
                                        <div className="col-md-4 col-sm-6 padding_0 margin_right20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img4.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 col-sm-6 padding_0 margin_top70p margin_right20 margin_left20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img2.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 col-sm-6 padding_0 margin_left20">
                                            <div className="services">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img1.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-md-4 offset-md-8 col-sm-6 padding_0 margin_top170">
                                            <div className="services margin_left60">
                                                <div className="services_img">
                                                    <figure><img src="images/service_img3.png" alt="#" />  </figure>
                                                    <div className="ho_dist">
                                                        <span>Sponsor</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="col-sm-6 margin_top40">
                                            <a className="read_more " href="/home">Entradas</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div className="instant">
                <div className="container-fluid">
                    <div className="row">
                        <div className="col-md-6">
                            <div className="titlepage text_align_left">
                                <h2>
                                    VISIÓN</h2>
                                <p>Nuestra visión es ser un club líder en lo deportivo y social, referente por la calidad y transparencia de su gestión institucional con un desarrollo de infraestructura de jerarquía internacional con estándar para el alto rendimiento deportivo.</p>
                                <a className="read_more" href="/home">Comprar</a>
                            </div>
                        </div>
                        <div className="col-md-6">
                            <div className="instant_img">
                                <figure><img src="images/pc.png" alt="#" /></figure>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer>
                <div className="footer">
                    
                    <div className="copyright text_align_center">
                        <div className="container">
                            <div className="row">
                                <div className="col-md-10 offset-md-1">
                                    <p>CDPG 2020 All Right Reserved By <a href="https://google.com/"> Algo</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </div >
    );
}
