//IMPORT
const mongoose = require("mongoose");
const express = require('express');

const cors = require('cors')


const authRouter = require('./routes/auth');
const accountRouter = require('./routes/account');
const courseRouter = require('./routes/course');
const userRouter = require("./routes/user");
const adminRouter = require("./routes/admin");
// INIT
const app = express();
const PORT = process.env.PORT || 3000;




//MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(accountRouter);
app.use(courseRouter);
app.use(userRouter);
app.use(adminRouter);

const corsOptions = {
    origin: '*', // or '*'
  };
  
app.use(cors(corsOptions))




app.listen(PORT, "0.0.0.0",()=>{
    console.log(`Connection successful at ${PORT}`)
})