const express = require("express");
const nodemailer = require("nodemailer");
const crypto = require('crypto');

require("dotenv").config();
const User = require("../models/user");
const auth = require("../middlewares/auth")
const authRouter = express.Router();
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const pool = require("../db");
const queries = require("../queries")

// Configuration from environment variables
const JWT_SECRET = process.env.JWT_SECRET || "super_secret_key_2026";

const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    secure: true,
    auth:{
        user: process.env.AUTH_EMAIL,
        pass: process.env.AUTH_PASS
    }
})

// Standardized Response Helper
const sendResponse = (res, { status, code, message, data = null }) => {
    return res.status(status).json({
        status,
        success: status < 400,
        code,
        message, // Human readable for dev logs
        data,
        timestamp: new Date().toISOString()
    });
};

function generateVerificationCode() {
    let code = '';
    for (let i = 0; i < 6; i++) {
        code += Math.floor(Math.random() * 10).toString();
    }
    return code;
}

// SIGNUP
authRouter.post('/api/v1/signup', async (req, res) => {
    try {
        const { nom, prenom, email, password } = req.body;
        const role = 1; 

        // 1. Validation
        if (!email || !password || password.length < 6) {
            return sendResponse(res, {
                status: 400,
                code: "AUTH_VALIDATION_ERROR",
                message: "Email required and password must be 6+ chars"
            });
        }

        // 2. Check if user exists (Using async/await instead of callbacks)
        const existingUser = await pool.query(queries.checkEmailExist, [email]);
        if (existingUser.rows.length > 0) {
            return sendResponse(res, {
                status: 409,
                code: "AUTH_EMAIL_ALREADY_EXISTS",
                message: "Email already taken"
            });
        }

        // 3. Hash Password & Generate Code
        const hashedPassword = await bcryptjs.hash(password, 12);
        const verify_code = generateVerificationCode();

        // 4. Save User
        const newUser = await pool.query(
            queries.addUser, 
            [nom, prenom, email, hashedPassword, role, verify_code]
        );
        const user = newUser.rows[0];

        // 5. Generate Token
        const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '7d' });
        user.token = token;

        // 6. Send Mail (Don't block the response for mail delivery)
        const mailOptions = {
            from: `"MBSchool" <${process.env.AUTH_EMAIL}>`,
            to: email,
            subject: "Code Verification - MBSchool",
            text: `Code: ${verify_code}`
        };

       // Await the mail so we can handle failure
        await transporter.sendMail(mailOptions);

        // If we reach here, the mail was sent successfully

        return sendResponse(res, {
                    status: 201,
                    code: "AUTH_USER_CREATED",
                    message: "Success",
                    data: user
                });

    } catch (e) {
        return sendResponse(res, {
                status: 500,
                code: "AUTH_MAIL_SEND_ERROR",
                message: "Compte créé mais le code n'a pas pu être envoyé."
            });
    }
});



authRouter.post('/api/v1/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        
        // 1. Check if user exists
        const { rows } = await pool.query(queries.checkEmailExist, [email]);
        if (rows.length === 0) {
            return sendResponse(res, { 
                status: 401, 
                code: "AUTH_INVALID_CREDENTIALS", 
                message: "Identifiants incorrects" 
            });
        }
        
        const user = rows[0];

        // 2. Check password
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return sendResponse(res, { 
                status: 401, 
                code: "AUTH_INVALID_CREDENTIALS", 
                message: "Identifiants incorrects" 
            });
        }

        // 3. CHECK VERIFICATION STATUS
        // If the user is not verified, we STOP here.
        if (user.verification_status === false || user.verification_status === 0) {
            // We still send the user data (id, email) so the frontend 
            // knows WHERE to send the new code, but we do NOT send a Token.
            return sendResponse(res, { 
                status: 403, 
                code: "AUTH_USER_NOT_VERIFIED", 
                message: "Compte non vérifié",
                data: { 
                    id: user.id, 
                    email: user.email 
                } 
            });
        }
        
        // 4. If verified, generate Token and finish Signin
        const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '30d' });
        
        // Cleanup sensitive data
        delete user.password;
        user.token = token;

        return sendResponse(res, { 
            status: 200, 
            code: "AUTH_SIGNIN_SUCCESS", 
            message: "Bienvenue", 
            data: user 
        });

    } catch (e) {
        console.error('Error during signin:', e);
        return sendResponse(res, { status: 500, code: "SERVER_ERROR", message: e.message });
    }
});


// Verify validity of token

// Verify validity of token
authRouter.post('/api/v1/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.json(false);

        // Verify token signature and expiration
        const verified = jwt.verify(token, process.env.JWT_SECRET || "mbschool_2026_key");
        if (!verified) return res.json(false);

        // checkIdExist returns rows if the user is still in the database
        const { rows } = await pool.query(queries.checkIdExist, [verified.id]);
        
        return res.json(rows.length > 0);
    } catch (e) {
        // If jwt.verify fails (expired/tampered), it throws an error
        return res.json(false);
    }
});

// Get user data
authRouter.get("/api/v1/user-data", auth, async (req, res) => {
    try {
        // req.user is populated by your auth middleware
        const { rows } = await pool.query(queries.checkIdExist, [req.user]);
        
        if (rows.length === 0) {
            return sendResponse(res, { status: 404, code: "USER_NOT_FOUND", message: "Utilisateur introuvable" });
        }

        const user = rows[0];
        delete user.password; // Never send the hash back
        user.token = req.token;

        return sendResponse(res, { 
            status: 200, 
            code: "USER_FETCH_SUCCESS", 
            message: "Success", 
            data: user 
        });
    } catch (e) {
        return sendResponse(res, { status: 500, code: "SERVER_ERROR", message: e.message });
    }
});


// Code de vérification
authRouter.post("/api/v1/codeVerification", async (req, res) => {
    try {
        const { id } = req.body;
        // Logic: update user status in DB once they provide the correct code
        await pool.query(queries.codeVerification, [id]);
        
        return sendResponse(res, { 
            status: 200, 
            code: "AUTH_VERIFIED", 
            message: "Compte vérifié avec succès" 
        });
    } catch (e) {
        return sendResponse(res, { status: 500, code: "SERVER_ERROR", message: e.message });
    }
});


// Verification of the 6-digit code
authRouter.post("/api/v1/verify-signup", async (req, res) => {
    try {
        const { userId, typedCode } = req.body;

        // 1. Fetch the code stored in the DB for this user
        const { rows } = await pool.query(queries.verifyCodeUser, [userId]);

        if (rows.length === 0) {
            return sendResponse(res, { status: 404, code: "USER_NOT_FOUND", message: "Utilisateur non trouvé" });
        }

        const dbCode = rows[0].verify_code;

        // 2. THE ACTUAL VERIFICATION
        if (dbCode !== typedCode) {
            return sendResponse(res, { 
                status: 400, 
                code: "AUTH_INVALID_CODE", 
                message: "Le code est incorrect" 
            });
        }

        // 3. If the code is correct, update the status to verified
        // We also clear the verify_code so it can't be used again
        await pool.query(
            queries.codeVerification, 
            [userId]
        );
        
        return sendResponse(res, { 
            status: 200, 
            code: "AUTH_VERIFIED", 
            message: "Compte vérifié avec succès" 
        });

    } catch (e) {
        return sendResponse(res, { status: 500, code: "SERVER_ERROR", message: e.message });
    }
});

// Resend code
authRouter.post("/api/v1/resend-code", async (req, res) => {
    try {
        const { email } = req.body;

        const { rows } = await pool.query(queries.checkEmailExist, [email]);
        if (rows.length === 0) {
            return sendResponse(res, { status: 404, code: "AUTH_USER_NOT_FOUND", message: "Email inconnu" });
        }

        const user = rows[0];
        const newCode = generateVerificationCode();

        // Update the code in the DB (assuming you have a query for this)
         await pool.query(queries.updateVerifyCode, [newCode, user.id]);

        const mailOptions = {
            from: `"MBSchool" <${process.env.AUTH_EMAIL}>`,
            to: email,
            subject: "Nouveau code de vérification",
            text: `Votre nouveau code est: ${newCode}`
        };

        await transporter.sendMail(mailOptions);

        return sendResponse(res, { 
            status: 200, 
            code: "AUTH_CODE_RESENT", 
            message: "Nouveau code envoyé",
            data: { email: user.email } 
        });
    } catch (e) {
        console.error(e);
        return sendResponse(res, { status: 500, code: "AUTH_RESEND_ERROR", message: "Échec de l'envoi du code" });
    }
});



// POST /api/forgot-password
authRouter.post('/api/v1/forgot-password', async (req, res) => {
    try {
        const { email } = req.body;
        const { rows } = await pool.query(queries.checkEmailExist, [email]);

        if (rows.length === 0) {
            // Standard security: don't confirm the email doesn't exist
            return sendResponse(res, { status: 202, code: "AUTH_RESET_REQUESTED", message: "Accepted" });
        }

        const user = rows[0];
        // Generate a simple 6-digit code for mobile convenience
        const resetCode = Math.floor(100000 + Math.random() * 900000).toString();
        
        // Code expires in 15 minutes (shorter is safer for OTPs)
        const expires = new Date(Date.now() + 15 * 60000); 

        await pool.query(
            queries.updateResetPasswordToken,
            [resetCode, expires, user.id]
        );

        await transporter.sendMail({
            from: `"MBSchool Support" <${process.env.AUTH_EMAIL}>`,
            to: email,
            subject: "Réinitialisation de votre mot de passe",
            text: `Votre code de réinitialisation est : ${resetCode}. Il expire dans 15 minutes.`
        });

        return sendResponse(res, { 
            status: 200, 
            code: "AUTH_RESET_CODE_SENT", 
            message: "Code envoyé" 
        });

    } catch (e) {
        return sendResponse(res, { status: 500, code: "SERVER_ERROR", message: e.message });
    }
});


// POST /api/reset-password
authRouter.post('/api/v1/reset-password', async (req, res) => {
    try {
        const { email, code, newPassword } = req.body;

        // 1. Find user with matching email, code, and valid expiration
        const { rows } = await pool.query(
            queries.findUserEmailCodeExpiry,
            [email, code]
        );

        if (rows.length === 0) {
            return sendResponse(res, { 
                status: 400, 
                code: "AUTH_INVALID_RESET_CODE", 
                message: "Code invalide ou expiré" 
            });
        }

        const userId = rows[0].id;
        const hashedPassword = await bcryptjs.hash(newPassword, 12);

        // 2. Update password and clear the reset fields
        await pool.query(
            queries.updatePasswordClearResetFields,
            [hashedPassword, userId]
        );

        return sendResponse(res, { 
            status: 200, 
            code: "AUTH_PASSWORD_CHANGED", 
            message: "Succès" 
        });

    } catch (e) {
        return sendResponse(res, { status: 500, code: "SERVER_ERROR", message: e.message });
    }
});


  


module.exports = authRouter;