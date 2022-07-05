function App() {

  const callServer = () => {
    alert("Hola mubdo")
  }

  return (
    <div onClick={callServer}>
      <h1>Click</h1>
    </div>
  );
}

export default App;
