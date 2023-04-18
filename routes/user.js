const express = require("express");
const auth = require("../middlewares/auth");
const User = require("../models/user");
const pool = require("../db");
const queries = require("../queries")

const userRouter = express.Router()



userRouter.post('/modifyRole',  async(req, res)=>{
    try {
        const { role, id_users}= req.body;

       pool.query(queries.modifyRole,[role, id_users], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})

userRouter.post('/activateUser',  async(req, res)=>{
    const statut = 1;
    try {
        const {id_users}= req.body;

       pool.query(queries.activateUser,[statut,id_users], (error, results)=>{
            if (error) throw error;
            return res.json(results.rows[0])
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})

userRouter.post('/desactivateUser',  async(req, res)=>{
    const statut = 0;
    try {
        const {id_users}= req.body;

       pool.query(queries.desactivateUser,[statut,id_users], (error, results)=>{
            if (error) throw error;
            return res.json(results.rows[0])
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})


userRouter.post('/deleteUser',  async(req, res)=>{
    try {
        const {id_users}= req.body;

       pool.query(queries.deleteUser,[id_users], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})
module.exports = userRouter;