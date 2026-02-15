const mongoose = require("mongoose")

const userSchema= mongoose.Schema({
    name:{
        type: String,
        required: true,
        trim: true
    },
    email:{
        type: String,
        required: true,
        trim: true,
        validate: {
            validator:(value)=>{
                const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
                },
                message:"SVP Entrez une adresse email valide"
        }
    },
    password:{
        type: String,
        required: true,
        trim: true
    },
    role:{
        type: String,
        default: "student"
    },
    image:{
        type: String,
        default: ""
    },
    
});
const User=mongoose.model('User', userSchema);
module.exports=User;
