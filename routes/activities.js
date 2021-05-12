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


//add an activity

router.post('/activities', (request, response) => {
    console.log(request.body);

    const { name, description, nbpax, location, image_1, image_2, image_3, image_4, price } = request.body;
    const values = [name, description, nbpax, location, image_1, image_2, image_3, image_4, price];
    console.log(values);
    const sql = "INSERT INTO `activity` (name, description, nbpax, location, image_1, image_2, image_3, image_4, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    connection.query(sql, values, (err, result) => {
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

//delete an activity

router.delete('/activities/:id', (request, response) => {

    const activityId = parseInt(request.params.id);

    console.log('ça delete!', activityId);

    connection.query('DELETE FROM `activity` WHERE id = ?', [activityId], (err, result) => {

        if(err) {
            response.status(500).send(`Error while deleting from database: ${err.stack}`);
        } else {
            response.status(200).send("Activity deleted!");
        }
    });
});

module.exports = router;