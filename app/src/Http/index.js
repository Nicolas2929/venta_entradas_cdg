const POST = (data) => {
    const options = {
        method: 'POST',
        body: JSON.stringify(data),
    };

    fetch('http://localhost:8080/api', options)
        .then(response => response.json())
        .then(response => {
            console.log(response)
        })
        .catch(err => console.error(err));
}

const Http = {
    POST
}

export default Http;