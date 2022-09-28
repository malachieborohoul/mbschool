//IMPORT
const mongoose = require("mongoose");
const express = require('express');


const authRouter = require('./routes/auth');
const accountRouter = require('./routes/account');
const courseRouter = require('./routes/course');
// INIT
const app = express();
const PORT = 3000;




//MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(accountRouter);
app.use(courseRouter);



app.listen(PORT, "0.0.0.0",()=>{
    console.log(`Connection successful at ${PORT}`)
})