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
  const {titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users, vignette}= req.body;
  pool.query(queries.addCourseWithoutPrice, [titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users, vignette] , (error, results)=>{
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
courseRouter.get("/getAllSections/:id_section",auth,  (req, res)=>{
  pool.query(queries.getAllSections,[req.params.id_section], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// add course section

courseRouter.post('/addSection',auth,  (req, res)=>{
  const {titre, id_cours}= req.body;

  pool.query(queries.addSection, [titre, id_cours], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows[0])
  })
})


// add course lesson

courseRouter.post('/createLesson',auth,  (req, res)=>{
  const {titre,resume, id_cours,id_section, id_type_lecon, url}= req.body;

  pool.query(queries.addLesson, [titre,resume, id_cours,id_section,id_type_lecon, url], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows[0])
  })
})


// get all lessons
courseRouter.get("/getAllLecons/:id_cours/:id_section", auth,  (req, res)=>{
  pool.query(queries.getAllLecons,[req.params.id_cours,req.params.id_section], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// modify course

courseRouter.post("/modifyCourse",  (req, res)=>{
  const {titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users, vignette, id_cours}= req.body;
  pool.query(queries.modifyCourse, [titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users, vignette, id_cours] , (error, results)=>{
    if (error) throw error;
    return res.json(true)
  })
});

// add course exigence

courseRouter.post('/addExigence',auth,  (req, res)=>{
  const {nom, id_cours}= req.body;

  pool.query(queries.addExigence, [nom, id_cours,], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows)
  })
})


// get all exigences
courseRouter.get("/getAllExigences/:id_exigence",auth,  (req, res)=>{
  pool.query(queries.getAllExigences,[req.params.id_exigence], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// get all courses by categorie
courseRouter.get("/getAllCoursesByCategory/:id_categorie",auth,  (req, res)=>{
  pool.query(queries.getAllCoursesByCategory,[req.params.id_categorie], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})


// get all enseignants populaires
courseRouter.get("/getAllEnseignantPopulaire",auth,  (req, res)=>{
  pool.query(queries.getAllEnseignantPopulaire, (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// add course to favorite

courseRouter.post("/addCourseToFavorite",auth, (req, res)=>{
  const {id_users, id_cours} = req.body;
  pool.query(queries.addCourseToFavorite,[id_users, id_cours], (error, results)=>{
    if(error) throw error;

    return res.json(results.rows[0])
  })
})

// remove course to favorite

courseRouter.post("/removeCoursToFavorite",auth, (req, res)=>{
  const {id_users, id_cours} = req.body;
  pool.query(queries.removeCoursToFavorite,[id_users, id_cours], (error, results)=>{
    if(error) throw error;

    return res.json(true)
  })
})

// fetch if a course is the favorite table

courseRouter.post("/isCourseInFavorite",auth, (req, res)=>{
  const {id_users, id_cours} = req.body;
  pool.query(queries.isCourseInFavorite,[id_users, id_cours], (error, results)=>{
    if(error) throw error;
    if(results.rowCount > 0 ){
      return res.json(true)
    }
    return res.json(false)

    
  })
})


// get all favorite courses
courseRouter.get("/getAllFavoriteCourses",auth,  (req, res)=>{
  pool.query(queries.getAllFavoriteCourses, (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})


// filter all the  courses
courseRouter.get("/filterCourses/:id_categorie/:id_niveau/:id_langue",auth, (req, res)=>{
  pool.query(queries.filterCourses,[req.params.id_categorie, req.params.id_niveau, req.params.id_langue], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })

})


// search all the  courses
courseRouter.get("/searchCourses/:titre", auth, (req, res)=>{
  pool.query(queries.searchCourses,[req.params.titre], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })

})

// add commentaire to lesson

courseRouter.post("/addLeconCommentaire",auth, (req, res)=>{
  const {intitule,users_id, lecon_id} = req.body;
  pool.query(queries.addLeconCommentaire,[intitule,users_id, lecon_id], (error, results)=>{
    if(error) throw error;

    return res.json(results.rows[0])
  })
})


// get all lesson commentaires
courseRouter.get("/getAllLessonCommentaires/:id_lecon", (req, res)=>{
  pool.query(queries.getAllLessonCommentaires,[req.params.id_lecon], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})

// get all lesson number reponses
courseRouter.get("/getAllLessonNumberReponses/:id_commentaire", (req, res)=>{
  pool.query(queries.getAllLessonNumberReponses,[req.params.id_commentaire], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows[0]['count']);

  })
})

// add response to commentaire about a lesson

courseRouter.post("/addLeconReponseCommentaire",auth, (req, res)=>{
  const {intitule,users_id, commentaire_id} = req.body;
  pool.query(queries.addLeconReponseCommentaire,[intitule,users_id, commentaire_id], (error, results)=>{
    if(error) throw error;

    return res.json(results.rows[0])
  })
})

// get all lesson reponse commentaires
courseRouter.get("/getAllLessonReponseCommentaires/:id_commentaire",auth, (req, res)=>{
  pool.query(queries.getAllLessonReponseCommentaires,[req.params.id_commentaire], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})


// count all lesson reponse and commentaires
courseRouter.get("/countAllLessonReponseAndCommentaires/:id_lecon",auth, (req, res)=>{
  pool.query(queries.countAllLessonReponseAndCommentaires,[req.params.id_lecon], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows[0]['count']);

  })
})


// enroll to course

courseRouter.post('/enrollToCourse',auth,  (req, res)=>{
  const {users_id, cours_id}= req.body;

  pool.query(queries.enrollToCourse, [users_id, cours_id], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows[0])
  })
})


// fetch if a course is already enrolled or not

courseRouter.post("/isCourseEnrolled",auth, (req, res)=>{
  const {users_id, cours_id} = req.body;
  pool.query(queries.isCourseEnrolled,[users_id, cours_id], (error, results)=>{
    if(error) throw error;
    if(results.rowCount > 0 ){
      return res.json(true)
    }
    return res.json(false)

    
  })
})


// get all enrolled courses
courseRouter.get("/getAllEnrolledCourses/:id", auth, (req, res)=>{
  pool.query(queries.getAllEnrolledCourses,[req.params.id], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})


// mark course as done

courseRouter.post('/markLessonAsDone',auth,  (req, res)=>{
  const {users_id, lecon_id}= req.body;

  pool.query(queries.markLessonAsDone, [users_id, lecon_id], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows[0])
  })
})

// fetch if a lecon has already been marked as done

courseRouter.post("/isLeconDone",auth, (req, res)=>{
  const {users_id, lecon_id} = req.body;
  pool.query(queries.isLeconDone,[users_id, lecon_id], (error, results)=>{
    if(error) throw error;
    if(results.rowCount > 0 ){
      return res.json(true)
    }
    return res.json(false)

    
  })
})


// fetch the number of lessons for a particular course

courseRouter.post("/getNumberLeconCours",auth, (req, res)=>{
  const {cours_id, } = req.body;
  pool.query(queries.getNumberLeconCours,[cours_id,], (error, results)=>{
    if(error) throw error;
    return res.json(results.rows[0]['count']);


    
  })
})


// fetch the number of lessons done by a student for a particular course

courseRouter.post("/getNumberLeconCoursDone",auth, (req, res)=>{
  const {cours_id, } = req.body;
  pool.query(queries.getNumberLeconCoursDone,[cours_id,], (error, results)=>{
    if(error) throw error;
    return res.json(results.rows[0]['count']);


    
  })
})

// rate a course

courseRouter.post('/rateCourse',auth,  (req, res)=>{
  const {id_users,id_cours, rating, testimonial}= req.body;

  pool.query(queries.rateCourse, [id_users,id_cours, rating, testimonial], (error, results)=>{
    if (error) throw error;
    return res.json(results.rows[0])
  })
})


// get all notation cours
courseRouter.get("/getAllNotationCours/:id_cours", (req, res)=>{
  pool.query(queries.getAllNotationCours,[req.params.id_cours], (error, results)=>{
    if (error) throw error;

    return res.json(results.rows);

  })
})









module.exports = courseRouter;