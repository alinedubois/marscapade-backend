const express = require('express');

const app = express();
const port = 8080;


app.listen(port, (result, error) => {
    if(error) {
        console.error(error);
    } else {
        console.log(`Server listening port: ${port}`)
    }
})