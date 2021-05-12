// Setup environment variables / .env file
require('dotenv').config(); //npm install dotenv
//DB config
const { Pool } = require('pg');
const connectionString = process.env.DATABASE_URL;

const connection = new Pool({
    connectionString,
});

const router = require('express').Router();

//get all circuits
router.get('/circuits', (request, response) => {
    const sql = "SELECT * FROM circuit";
    connection.query(sql)
    .then((data) => {
        response.status(200).json(data.rows);
    })
    .catch((err) => {
        response.status(500).send(`Error retrieving data from database: ${err.stack}`);
    });
});

//get a specific circuit
router.get('/circuits/:id', (request, response) => {
    const circuitId = parseInt(request.params.id);

    const query = {
        text: "SELECT * FROM circuit WHERE id = $1",
        values: [circuitId],
    }
    connection.query(query, (err, results) => {

        if(err) {
          response.status(500).send('Error retrieving data from database');
        } else if(results && results.rows && results.rows.length > 0){
          response.status(200).json(results.rows[0]);
        } else {
          response.status(404).send('Not Found!');
        }
    });

});

//add an activity

router.post('/circuits', (request, response) => {

    const { title, description, distance, duration, difflevel, image_1, image_2, image_3, image_4 } = request.body;
    const values = [title, description, distance, duration, difflevel, image_1, image_2, image_3, image_4];

    const sql = "INSERT INTO circuit (title, description, distance, duration, difflevel, image_1, image_2, image_3, image_4) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)";

    const query = {
        text: sql,
        values: values,
    }
    connection.query(query, (err, result) => {
        if(err) {
            response.status(500).send(`Error while inserting into database: ${err.stack}`);
        } else {
            response.status(201).send('Circuit added!')
        }
    })

})

//delete an circuit

router.delete('/circuits/:id', (request, response) => {

    const circuitId = parseInt(request.params.id);

    console.log('ça delete!', circuitId);

    const query = {
        text: 'DELETE FROM circuit WHERE id = $1',
        values: [circuitId],
    }
    connection.query(query, (err, result) => {

        if(err) {
            response.status(500).send(`Error while deleting from database: ${err.stack}`);
        } else {
            response.status(200).send("Circuit deleted!");
        }
    });
});

module.exports = router;