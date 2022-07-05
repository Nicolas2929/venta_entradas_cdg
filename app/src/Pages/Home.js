import * as React from 'react';
import { useNavigate } from 'react-router-dom'
import Http from '../Http';
export default function Home() {
  const navigate = useNavigate();

  return (
    <div>
      <h1>Inicio</h1>
      <h4 onClick={() => {
        navigate("login");
      }}>Go to login</h4>
      <h4 onClick={() => {
        navigate("test");
      }}>Go to test</h4>
      <h4 onClick={() => {
        Http.POST({
          component: "usuario", type: "getAll",
        });
      }}>Http send</h4>
    </div>
  );
}
