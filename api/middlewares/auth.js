const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');

        // 1. Check if token exists
        if (!token) {
            return res.status(401).json({
                status: 401,
                success: false,
                code: "AUTH_MISSING_TOKEN",
                message: "Accès refusé, jeton manquant"
            });
        }

        // 2. Verify token (Use process.env for security)
        const verified = jwt.verify(token, process.env.JWT_SECRET || "mbschool_2026_key");

        if (!verified) {
            return res.status(401).json({
                status: 401,
                success: false,
                code: "AUTH_TOKEN_INVALID",
                message: "La vérification du jeton a échoué"
            });
        }

        // 3. Pass data to the next function
        req.user = verified.id; // The user ID from the payload
        req.token = token;
        
        next();
    } catch (e) {
        // If jwt.verify fails due to expiration or tampering, it hits this catch
        return res.status(401).json({ 
            status: 401, 
            success: false,
            code: "AUTH_SESSION_EXPIRED",
            message: e.message 
        });
    }
}

module.exports = auth;