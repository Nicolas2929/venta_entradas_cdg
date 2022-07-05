function App() {

  const callServer = () => {

    var data = {
      component: "usuario", type: "getAll"
    }
    const options = {
      method: 'POST',
      body: JSON.stringify(data),
    };

    fetch('http://192.168.3.2/api', options)
      .then(response => response.json())
      .then(response => console.log(response))
      .catch(err => console.error(err));
  }

  return (
    <div onClick={callServer}>
      <h1>Click</h1>
    </div>
  );
}

export default App;
