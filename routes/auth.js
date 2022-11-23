const express = require("express");
const nodemailer = require("nodemailer");

require("dotenv").config();
const User = require("../models/user");
const auth = require("../middlewares/auth")
const authRouter = express.Router();
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const pool = require("../db");
const queries = require("../queries")

const transporter = nodemailer.createTransport({
    service: "gmail",
    auth:{
        user: process.env.AUTH_EMAIL,
        pass: process.env.AUTH_PASS
    }
})

// transporter.verify((error, success)=>{
//     if(error){
//         console.log(error)
//     }else{
//         console.log("Ready for message")
//         console.log(success )
//     }
// })


// SIGNUP
authRouter.post('/api/signup', async (req, res)=> {
    try {
        const {nom, prenom, email, password} = req.body;
        const role = 1;
        const verify_code=123457
        pool.query(queries.checkEmailExist,[email], async (error, results)=>{
            
            if(results.rows.length){
                return res.status(400).json({msg:"Cet email existe déjà"});
            }
            if(password.length < 6){
                return res.status(400).json({msg: "Mot de passe trop court. Au moins 6 caractères"});
            }
            const hashedPassword = await bcryptjs.hash(password, 8);

            pool.query(queries.addUser, [nom, prenom, email, hashedPassword, role, verify_code], (error, results)=>{
                const user = results.rows[0];
                if (error) throw error;

                const token = jwt.sign({id: user.id}, "passwordKey");
                const verify_code="123456"
                user.token = token;
                user.verify_code = verify_code;

                // sendEmailVerification(user,res);
                // return res.json();
                    
                // res.status(200).json(user);

                const mailOptions={
                    from: process.env.AUTH_EMAIL,
                    to: email,
                    subject: "Code de vérification",
                    text: verify_code
                }
                transporter.sendMail(mailOptions)
                    .then(()=>{
                        // return res.json({
                        //     message: "SUCCESS",
                        //     message: "Message sent succesfully"
                        // })
                        res.status(200).json(user);
                    })
                    .catch((error)=>{
                        console.log(error);
                         res.status(400).json("Message non envoyé")
                    })
            })
        } )

    // const existingEmail = await User.findOne({email});
    // if(existingEmail) {
    //     return res.status(400).json({msg:"Cet email existe déjà"})
    // };

    // if(password.length < 6){
    //     return res.status(400).json({msg: "Mot de passe trop court. Au moins 6 caractères"});
    // }

    // const hashedPassword = await bcryptjs.hash(password, 8);
    // let user = new User(
    //     {
    //         name,
    //         email,
    //         password: hashedPassword,
    //     }
    // )

    // user =await user.save()
    // res.json(user)
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }
});

// SIGNIN USER

authRouter.post('/api/signin', async(req, res)=> {
    try {
        const {email, password} = req.body;
        pool.query(queries.checkEmailExist,[email], async (error, results)=>{
            const user=results.rows[0];
            if(!results.rows.length){
                return res.status(400).json({msg: "Cet identifiant n'existe pas"});
            }
            const isPass = await bcryptjs.compare(password, user.password);
            if(!isPass){
                return res.status(400).json({msg: "Mot de passe incorrecte"});
            }
            
            const token = jwt.sign({id: user.id}, "passwordKey");
            user.token = token;
            return res.json(user);
        } )

        // const user = await User.findOne({email});

        // if(!user){
        //     return res.status(400).json({msg: "Cet identifiant n'existe pas"});
        // }

        // const isPass = await bcryptjs.compare(password, user.password);

        // if(!isPass){
        //     return res.status(400).json({msg: "Mot de passe incorrecte"});
        // }

        // const token = jwt.sign({id: user._id}, "passwordKey");
        // res.json({token, ...user._doc});

    } catch (e) {
        return res.status(500).json({error: e.message});
    }
});


// Verify validity of token

authRouter.post('/tokenIsValid', async (req, res)=>{
    try {
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);
        const tokenIsValid= await jwt.verify(token, "passwordKey");
        if(!tokenIsValid) return res.json(false)
        pool.query(queries.checkIdExist, [tokenIsValid.id], (error, results)=>{
            if(!results.rows.length){
                return res.json(false);
            }
            return res.json(true);
        })
        // const user = await User.findById(tokenIsValid.id);
        // if(!user) return res.json(false);
        // return res.json(true);

        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
    pool.query(queries.checkIdExist, [req.user], (error, results)=>{
        const user = results.rows[0];
        user.token = req.token;
        // print(user);

        return res.json(user);

    })
    // const user = await User.findById(req.user);
    // return res.json({ ...user._doc, token: req.token });
    // print(user);
  });



  // Code de vérification
  authRouter.post("/codeVerification",  (req, res)=>{
    const {id}= req.body;
    pool.query(queries.codeVerification, [id, ] , (error, results)=>{
      if (error) throw error;
      return res.json(true)
    })
  });


  const sendEmailVerification = ({email, verify_code}, res)=>{
    // const {to, subject, message}=req.body;

    const mailOptions={
        from: process.env.AUTH_EMAIL,
        to: email,
        subject: "Code de vérification",
        text: verify_code
    }
    transporter.sendMail(mailOptions)
        .then(()=>{
            return res.json({
                message: "SUCCESS",
                message: "Message sent succesfully"
            })
        })
        .catch((error)=>{
            console.log(error);
            return res.json({status: "FAILED", message:"An error"})
        })
}



  


module.exports = authRouter;