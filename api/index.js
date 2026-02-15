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



// CORS Configuration
const corsOptions = {
    origin: 'http://localhost:4200', // Allow your Angular app origin
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS', // Allow common HTTP methods
    credentials: true, // Allow credentials (if needed, e.g., cookies, authorization headers)
    allowedHeaders: 'Content-Type,Authorization', // Allow specific headers
  };
  
  // Apply CORS middleware
  app.use(cors(corsOptions));
  
  

//MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(accountRouter);
app.use(courseRouter);
app.use(userRouter);
app.use(adminRouter);




app.listen(PORT, "0.0.0.0",()=>{
    console.log(`Connection successful at ${PORT}`)
})