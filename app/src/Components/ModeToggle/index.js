import React from 'react';
import { Button, TextField } from '@mui/material';
// ...other imports

const ModeToggle = () => {
 
  return (
    <div>
 <TextField
    // html input attribute
    name="email"
    type="email"
    placeholder="johndoe@email.com"
    // pass down to FormLabel as children
    label="Email"
  />
  <TextField
    name="password"
    type="password"
    placeholder="password"
    label="Password"
  />
    </div>
     
    
  );
};

export default ModeToggle;