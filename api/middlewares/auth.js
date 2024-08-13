const jwt = require("jsonwebtoken")

const auth = async (req, res, next)=>{
    try {
        const token = req.header('x-auth-token');

        if(!token)
            return res.status(401).json({msg: "Pas de token , access refusé"});
            const verified = jwt.verify(token, "passwordKey");

            if(!verified)
                return res.status(401).json({msg: 'Verification du token a échoué, autorisation refusée'});

            req.user = verified.id;
            req.token = token;
            next();
        
    } catch (e) {
        return res.status(500).json({error: e.message})
    }
}

module.exports = auth