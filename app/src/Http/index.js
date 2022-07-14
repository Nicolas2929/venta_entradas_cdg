const POST = async (data, callback) => {
    const options = {
        method: 'POST',
        body: JSON.stringify(data),
    };

    fetch('http://192.168.0.208:8080/api', options)
        .then(response => response.json())
        .then(response => {
            callback(response);
        })
        .catch(err => console.error(err));
}

const Http = {
    POST
}

export default Http;