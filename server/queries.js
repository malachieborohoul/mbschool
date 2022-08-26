const checkEmailExist = "SELECT * FROM users WHERE email = $1";
const addUser = "INSERT INTO users (nom, prenom, email, password, role) VALUES ($1, $2, $3, $4, $5) RETURNING *";
const editUserProfile = 'UPDATE users SET nom = $1, photo = $2, prenom = $3, telephone = $4, sexe = $5, localisation = $6 WHERE id = $7;';
const checkIdExist = "SELECT * FROM users WHERE id = $1";
const getAllLangueData = "SELECT * FROM langue;";
const getAllCategorieData = "SELECT * FROM categorie;";
const getAllNiveauData = "SELECT * FROM niveau;";
const addCourseWithoutPrice = "INSERT INTO cours (titre, description, description_courte, id_categorie, id_niveau, id_langue, id_users, vignette) VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *;";
const addSection = "INSERT INTO section (titre, id_cours) VALUES ($1, $2) RETURNING *;"
const addLesson = "INSERT INTO lecon (titre, resume, id_cours, id_section, id_type_lecon, url) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;"
const getAllCourses = "SELECT * FROM cours JOIN users ON cours.id_users=users.id;";
const getAllSections = "SELECT * FROM section WHERE id_cours = $1;";
const getAllLecons = "SELECT * FROM lecon WHERE id_cours = $1 AND id_section = $2;";
const modifyCourse = "UPDATE cours SET titre = $1, description = $2, description_courte= $3, id_categorie = $4, id_niveau=$5, id_langue=$6, id_users=$7, vignette=$8 WHERE id_cours = $9;";
const addExigence = "INSERT INTO exigence (nom,  id_cours) VALUES ($1, $2) RETURNING *;"
const getAllExigences = "SELECT * FROM exigence WHERE id_cours = $1;";
const getAllCoursesByCategory = "SELECT * FROM cours JOIN users ON cours.id_users = users.id WHERE id_categorie = $1;";
const getAllEnseignantPopulaire = "SELECT cours.id_users, users.nom, users.prenom,users.photo, COUNT(*) AS nombre_cours FROM cours JOIN users ON cours.id_users = users.id GROUP BY cours.id_users, users.nom,users.prenom, users.photo ;";

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
    addLesson,
    getAllLecons,
    modifyCourse,
    addExigence,
    getAllExigences,
    getAllCoursesByCategory,
    getAllEnseignantPopulaire,
}