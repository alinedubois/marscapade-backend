// Setup environment variables / .env file
require('dotenv').config(); //npm install dotenv
//DB config
const connection = require('../db-config');

connection.connect((err) => {
    if(err){
        console.error(`error connecting: ${err.stack}`);
    } else {
        console.log(`connected to database with threadid: ${connection.threadId}`);
    }
});

const router = require('express').Router();

//get all activities
router.get('/activities', (request, response) => {
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
router.get('/activities/:id', (request, response) => {

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

module.exports = router;