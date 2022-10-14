const express = require("express");
const auth = require("../middlewares/auth");
const User = require("../models/user");
const pool = require("../db");
const queries = require("../queries")

const adminRouter = express.Router()

// add categorie

adminRouter.post('/addCategorie',auth,  (req, res)=>{
    const {nom,}= req.body;
  
    pool.query(queries.addCategorie, [nom], (error, results)=>{
      if (error) throw error;
      return res.json(results.rows[0])
    })
  })
  

adminRouter.post('/activateUser',  async(req, res)=>{
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

adminRouter.post('/desactivateUser',  async(req, res)=>{
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


adminRouter.post('/deleteUser',  async(req, res)=>{
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
module.exports = adminRouter;