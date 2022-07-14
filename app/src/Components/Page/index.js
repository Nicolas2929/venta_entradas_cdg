import * as React from 'react';
import TopBar from '../TopBar';
export default function Page(props) {
    return <div>
        <TopBar />
        {props.children}
    </div>
}