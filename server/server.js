const express = require("express");
const zooRoute = require('./routes/zookeeper');
require('dotenv').config();


const app = express();
app.use(express.json());
app.use(`/${process.env.API_CODE}`,zooRoute);



const port = process.env.SERVER_PORT;
app.listen(port,()=>console.log(`Server is running on port ${port}`));