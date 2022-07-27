const POST = async (data, callback) => {
    const options = {
        method: 'POST',
        body: JSON.stringify(data),
    };

    fetch('http://localhost:8080/api', options)
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
        mode: 'cors'
    };

    fetch('http://192.168.5.34:30034/api', options)
        .then(response => response.json())
        .then(response => {
            callback(response);
        }).catch(err => {
            console.error(err)
        });
}

const Http = {
    POST,
    QRAPI
}

export default Http;