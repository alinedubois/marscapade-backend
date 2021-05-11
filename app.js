// Setup environment variables / .env file
require('dotenv').config(); //npm install dotenv
//DB config
const connection = require('./db-config');

connection.connect((err) => {
    if(err){
        console.error(`error connecting: ${err.stack}`);
    } else {
        console.log(`connected to database with threadid: ${connection.threadId}`);
    }
});

//Express setup
const express = require('express');
const app = express();

// Using express.json() middleware
app.use(express.json());

const port = process.env.PORT || 3000;

app.listen(port, (result, error) => {
    if(error) {
        console.error(`error starting http server: ${err.stack}`);
    } else {
        console.log(`Server listening port: ${port}`)
    }
})

//get all activities
app.get('/activities', (request, response) => {
    const sql = "SELECT * FROM activity";
    connection.promise().query(sql)
    .then((data) => {
        response.status(200).json(data[0]);
    })
    .catch((err) => {
        response.status(500).send(`Error retrieving data from database: ${err.stack}`);
    });
});

//get a specific activities
app.get('/activities/:id', (request, response) => {

    const activityId = parseInt(request.params.id);

    const sql = "SELECT * FROM activity WHERE id = ?";
    connection.promise().query(sql, activityId)
    .then((data) => {
        const result = data[0];

        if(result && result.length > 0){
            response.status(200).json(result);
          } else {
            response.status(404).send('Not Found!');
          }
    })
    .catch((err) => {
        response.status(500).send(`Error retrieving data from database: ${err.stack}`);
    });
});

//get all circuits
app.get('/circuits', (request, response) => {
    const sql = "SELECT * FROM circuit";
    connection.promise().query(sql)
    .then((data) => {
        response.status(200).json(data[0]);
    })
    .catch((err) => {
        response.status(500).send(`Error retrieving data from database: ${err.stack}`);
    });
});

//get a specific circuit
app.get('/circuits/:id', (request, response) => {
    const circuitId = parseInt(request.params.id);

    const sql = "SELECT * FROM circuit WHERE id = ?";
    connection.query(sql, circuitId, (err, results) => {

        if(err) {
          response.status(500).send('Error retrieving data from database');
        } else if(results && results.length > 0){
          response.status(200).json(results);
        } else {
          response.status(404).send('Not Found!');
        }
    });

});

