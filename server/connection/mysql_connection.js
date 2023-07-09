const mysql = require("mysql");
require('dotenv').config();

//database connection
const connection = mysql.createConnection({
    host: process.env.HOST_DB,
    user: process.env.USER_DB,
    password: process.env.PASSWORD_DB,
    database: process.env.DATABASE_NAME
});

connection.connect((error) => {
    if (error) {
        return console.log(error);
    }
    console.log('MySql successfully connected!');
});

module.exports = connection