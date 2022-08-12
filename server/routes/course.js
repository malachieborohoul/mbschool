const express = require("express");
const User = require("../models/user");
const auth = require("../middlewares/auth")
const courseRouter = express.Router();
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const pool = require("../db");
const queries = require("../queries")


// get langue data
courseRouter.get("/getAllLangueData",auth,  async (req, res) => {
    pool.query(queries.getAllLangueData,  (error, results)=>{
        const langues = results.rows;
        // user.token = req.token;
        // print(user);

        return res.json(langues);

    })
    // const user = await User.findById(req.user);
    // return res.json({ ...user._doc, token: req.token });
    // print(user);
  });


  // get categorie data
courseRouter.get("/getAllCategorieData",auth,  async (req, res) => {
  pool.query(queries.getAllCategorieData,  (error, results)=>{
      const categorie = results.rows;
      // user.token = req.token;
      // print(user);

      return res.json(categorie);

  })
  // const user = await User.findById(req.user);
  // return res.json({ ...user._doc, token: req.token });
  // print(user);
});

  // get niveau data
  courseRouter.get("/getAllNiveauData",auth,  async (req, res) => {
    pool.query(queries.getAllNiveauData,  (error, results)=>{
        const niveau = results.rows;
        // user.token = req.token;
        // print(user);
  
        return res.json(niveau);
  
    })
    // const user = await User.findById(req.user);
    // return res.json({ ...user._doc, token: req.token });
    // print(user);
  });

// create course

courseRouter.post("/createCourse", auth, (req, res)=>{
  const {titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users}= req.body;
  pool.query(queries.addCourseWithoutPrice, [titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users] , (error, results)=>{
    const cours = results.rows[0];
    if (error) throw error;
    return res.json(cours)
  })
});


// get all courses
courseRouter.get("/getAllCourses",auth,  (req, res)=>{
  pool.query(queries.getAllCourses, (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// get all sections
courseRouter.get("/getAllSections/:id_section",  (req, res)=>{
  pool.query(queries.getAllSections,[req.params.id_section], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// add course section

courseRouter.post('/addSection',  (req, res)=>{
  const {titre, id_cours}= req.body;

  pool.query(queries.addSection, [titre, id_cours], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows[0])
  })
})



module.exports = courseRouter;