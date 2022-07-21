import { Route } from 'react-router-dom';

import Home from './Home';

const Name = "admin";
export default [
    <Route path={Name + ''} element={<Home />} />,
]