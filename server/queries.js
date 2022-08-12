const checkEmailExist = "SELECT * FROM users WHERE email = $1";
const addUser = "INSERT INTO users (nom, prenom, email, password, role) VALUES ($1, $2, $3, $4, $5) RETURNING *";
const editUserProfile = 'UPDATE users SET nom = $1, photo = $2, prenom = $3, telephone = $4, sexe = $5, localisation = $6 WHERE id = $7;';
const checkIdExist = "SELECT * FROM users WHERE id = $1";
const getAllLangueData = "SELECT * FROM langue;";
const getAllCategorieData = "SELECT * FROM categorie;";
const getAllNiveauData = "SELECT * FROM niveau;";
const addCourseWithoutPrice = "INSERT INTO cours (titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *;";
const addSection = "INSERT INTO section (titre, id_cours) VALUES ($1, $2) RETURNING *;"
const getAllCourses = "SELECT * FROM cours;";
const getAllSections = "SELECT * FROM section WHERE id_cours = $1;";

module.exports = {
    checkEmailExist,
    addUser,
    editUserProfile,
    checkIdExist,
    getAllLangueData,
    getAllCategorieData,
    getAllNiveauData,
    addCourseWithoutPrice,
    getAllCourses,
    addSection,
    getAllSections,
}