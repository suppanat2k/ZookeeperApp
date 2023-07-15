const mysql = require("mysql");
require('dotenv').config();

//database connection
const connection = mysql.createConnection({
    host: process.env.HOST_DB,
    user: process.env.USER_DB,
    password: process.env.PASSWORD_DB,
    database: process.env.DATABASE_NAME,
    port: process.env.PORT_DB
});

connection.connect((error) => {
    if (error) {
        return console.log(error);
    }
    console.log('MySql successfully connected!');
});

connection.on('error', function (err) {
    console.log('db error', err);
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
        handleDisconnect();
    } else {
        throw err;
    }
});

module.exports = connection