// Setup environment variables / .env file
require('dotenv').config(); //npm install dotenv
//DB config
const { Pool } = require('pg');
const connectionString = process.env.DATABASE_URL;

const connection = new Pool({
    connectionString,
});

const router = require('express').Router();

//add an activity

router.post('/activities', (request, response) => {
    console.log(request.body);

    const { name, description, nbpax, location, image_1, image_2, image_3, image_4, price } = request.body;
    const values = [name, description, nbpax, location, image_1, image_2, image_3, image_4, price];
    console.log(values);
    const sql = "INSERT INTO activity (name, description, nbpax, location, image_1, image_2, image_3, image_4, price) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)";

    const query = {
        text: sql,
        values: values,
    }
    connection.query(query, (err, result) => {
        if(err) {
            response.status(500).send(`Error while inserting into database: ${err.message}`);
        } else {
            response.status(201).send('Activity added!')
        }
    })

});

//get all activities
router.get('/activities', (request, response) => {

    const sql = "SELECT * FROM activity";
    connection.query(sql)
    .then((data) => {
        response.status(200).json(data.rows);
    })
    .catch((err) => {
        response.status(500).send(`Error retrieving data from database: ${err.stack}`);
    });
});

//get a specific activities
router.get('/activities/:id', (request, response) => {

    const activityId = parseInt(request.params.id);

    const sql = "SELECT * FROM activity WHERE id = $1";
    const query = {
        text: sql,
        values: [activityId],
    }
    connection.query(query)
    .then((data) => {
        const result = data;

        if(result && result.rows && result.rows.length > 0){
            response.status(200).json(result.rows[0]);
          } else {
            response.status(404).send('Not Found!');
          }
    })
    .catch((err) => {
        response.status(500).send(`Error retrieving data from database: ${err.stack}`);
    });
});

//delete an activity

router.delete('/activities/:id', (request, response) => {

    const activityId = parseInt(request.params.id);

    console.log('ça delete!', activityId);

    const query = {
        text: 'DELETE FROM activity WHERE id = $1',
        values: [activityId],
    }
    connection.query(query, (err, result) => {

        if(err) {
            response.status(500).send(`Error while deleting from database: ${err.stack}`);
        } else {
            response.status(200).send("Activity deleted!");
        }
    });
});

module.exports = router;