const {ONE_SIGNAL_CONFIG}= require("../config/app.config")

const express = require("express");
const auth = require("../middlewares/auth");
const User = require("../models/user");
const pool = require("../db");
const queries = require("../queries");
const pushNotificationService = require("./push-notification");

const adminRouter = express.Router()

// add categorie

adminRouter.post('/addCategorie',auth,  (req, res)=>{
    const {nom,}= req.body;
  
    pool.query(queries.addCategorie, [nom], (error, results)=>{
      if (error) throw error;
      return res.json(results.rows[0])
    })
  })


  adminRouter.post('/deleteCategorie',  async(req, res)=>{
    try {
        const {id_categorie}= req.body;

       pool.query(queries.deleteCategorie,[id_categorie], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

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


adminRouter.post('/editCategorie',  async(req, res)=>{
    try {
        const {id_categorie,nom}= req.body;

       pool.query(queries.editCategorie,[nom,id_categorie], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})

// add langue

adminRouter.post('/addLangue',auth,  (req, res)=>{
    const {nom,}= req.body;
  
    pool.query(queries.addLangue, [nom], (error, results)=>{
      if (error) throw error;
      return res.json(results.rows[0])
    })
  })

adminRouter.post('/deleteLangue',  async(req, res)=>{
    try {
        const {id_langue}= req.body;

       pool.query(queries.deleteLangue,[id_langue], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})


adminRouter.post('/editLangue',  async(req, res)=>{
    try {
        const {id_langue,nom}= req.body;

       pool.query(queries.editLangue,[nom,id_langue], (error, results)=>{
            if (error) throw error;
            return res.json(true)
       })
    
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})

adminRouter.get("/SendNotification",exports.SendNotification=(req, res, next)=>{
    var message ={
       app_id: ONE_SIGNAL_CONFIG.APP_ID ,
       contents: {"en":"Test Push Notification" },
       included_segments:["All"],
       content_available: true,
       small_icon: "ic_notification_icon",
       data:{
        PushTitle:  "CUSTOM NOTIFICATION"
       },

    };

    pushNotificationService.SendNotification(message, (error, results)=>{
        if(error){
            return next(error);
        }
        return res.status(200).send(
            {
                message:"Success",
                data: results,
            }
        )
    })


})


adminRouter.post("/SendNotificationToDevice",exports.SendNotificationToDevice=(req, res, next)=>{
    var message ={
       app_id: process.env.APP_ID ,
       contents: {"en":"Test Push Notification" },
       included_segments:["included_player_ids"],
       include_player_ids: req.body.devices,
       content_available: true,
       small_icon: "ic_notification_icon",
       data:{
        PushTitle:  "CUSTOM NOTIFICATION"
       },

    };

    pushNotificationService.SendNotification(message, (error, results)=>{
        if(error){
            return next(error);
        }
        return res.status(200).send(
            {
                message:"Success",
                data: results,
            }
        )
    })


})

module.exports = adminRouter;