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

//get all circuits
router.get('/circuits', (request, response) => {
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
router.get('/circuits/:id', (request, response) => {
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

//add an activity

router.post('/circuits', (request, response) => {

    const { title, description, distance, duration, difflevel, image_1, image_2, image_3, image_4 } = request.body;
    const values = [title, description, distance, duration, difflevel, image_1, image_2, image_3, image_4];

    const sql = "INSERT INTO `circuit` (title, description, distance, duration, difflevel, image_1, image_2, image_3, image_4) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    connection.query(sql, values, (err, result) => {
        if(err) {
            response.status(500).send(`Error while inserting into database: ${err.stack}`);
        } else {
            response.status(201).send('Circuit added!')
        }
    })

})

module.exports = router;