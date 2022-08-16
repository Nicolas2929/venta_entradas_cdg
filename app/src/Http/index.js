const URL_SERVER = "http://192.168.3.2:8080/api"
const URL_PAGE = "http://192.168.3.2:3000"
const POST = async (data, callback) => {
    const options = {
        method: 'POST',
        body: JSON.stringify(data),
    };

    fetch(URL_SERVER, options)
        .then(response => response.json())
        .then(response => {
            callback(response);
        })
        .catch(err => console.error(err));
}
const QRAPI = async (contenido, callback) => {
    var data = {
        "component": "qr",
        "estado": "cargando",
        "data": {
            "colorBackground": "#ffffff",
            "framework": "Rounded",
            "header": "Rounded",
            "colorHeader": "#000000",
            "body": "Rounded",
            "content": contenido,
            "colorBody": "#000000"
        },
        "type": "registro"
    }

    const options = {
        method: 'POST',
        body: JSON.stringify(data),
    };

    fetch('http://qr.servisofts.com/api/api', options)
        // fetch('http://192.168.3.2:30034/api', options)
        .then(response => response.json())
        .then(response => {
            callback(response);
        }).catch(err => {
            console.error(err)
        });
}

const Http = {
    URL_SERVER,
    URL_PAGE,
    POST,
    QRAPI
}

export default Http;