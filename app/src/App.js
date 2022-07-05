import * as React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Routes
} from 'react-router-dom';


import Home from './Pages/Home';
import Login from './Pages/Login';
import Test from './Pages/Test';

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path='/' element={<Home />} />
        <Route path='login' element={<Login />} />
        <Route path='test' element={<Test />} />
      </Routes>
    </Router>
  )
}
