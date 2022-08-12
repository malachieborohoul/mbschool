const express = require("express");
const auth = require("../middlewares/auth");
const User = require("../models/user");
const pool = require("../db");
const queries = require("../queries")

const accountRouter = express.Router()

accountRouter.post('/api/editUserProfile', auth, async(req, res)=>{
    try {
        const {nom, photo, prenom, telephone, sexe, localisation}= req.body;

       pool.query(queries.editUserProfile,[nom, photo, prenom, telephone,sexe, localisation, req.user], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    // const user= await  User.updateOne({_id: req.user}, {$set:{name: name, image: image} });
    // if(!user) return false;

    // return res.json(true)
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})
module.exports = accountRouter;