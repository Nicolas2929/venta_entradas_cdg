import { Route } from 'react-router-dom';
import Home from './Home';
import R1 from './r1'
const Name = "report";

export default [
    <Route path={Name + ''} element={<Home />} />,
    <Route path={Name + '/:key'} element={<R1 />} />,
]