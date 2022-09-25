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
const addCourseToFavorite = "INSERT INTO favoris (id_users, id_cours) VALUES ($1, $2) RETURNING *;";
const isCourseInFavorite = "SELECT * FROM favoris WHERE id_users = $1 AND id_cours=$2;";
const removeCoursToFavorite = "DELETE FROM favoris WHERE id_users=$1 AND id_cours=$2;";
const getAllFavoriteCourses = "SELECT * FROM favoris JOIN cours ON cours.id_cours=favoris.id_cours;";
const filterCourses = "SELECT * FROM cours WHERE id_categorie=$1 OR id_niveau=$2 OR id_langue=$3;";
const searchCourses = "SELECT * FROM cours WHERE titre ILIKE '%' || $1 || '%'"
const addLeconCommentaire = "INSERT INTO commentaire (intitule,users_id, lecon_id) VALUES ($1, $2, $3) RETURNING *;";
// const getAllLessonCommentaires ="SELECT users.nom, users.prenom, users.photo, commentaire.intitule,commentaire.id_commentaire FROM commentaire JOIN users ON users.id=commentaire.users_id WHERE commentaire.lecon_id=$1 ORDER BY created_at DESC;";
const getAllLessonCommentaires ="SELECT intitule,nom,prenom,photo,id_commentaire, COUNT(*) AS number_reponses  FROM reponse JOIN commentaire ON reponse.commentaire_id=commentaire.id_commentaire  JOIN users ON commentaire.users_id =users.id WHERE lecon_id=$1 GROUP BY id_commentaire, users.nom, users.prenom, users.photo ORDER BY commentaire.created_at DESC;";
const addLeconReponseCommentaire = "INSERT INTO reponse (intitule_reponse,users_id, commentaire_id) VALUES ($1, $2, $3) RETURNING *;";
const getAllLessonReponseCommentaires ="SELECT users.nom, users.prenom, users.photo, reponse.intitule_reponse,reponse.id_reponse FROM reponse JOIN users ON users.id=reponse.users_id  WHERE commentaire_id=$1 ORDER BY created_at DESC;";
const countAllLessonReponseAndCommentaires ="SELECT reponse.commentaire_id AS id_commentaire, COUNT(*)+1 AS number_discussions FROM reponse JOIN commentaire ON commentaire.id_commentaire = reponse.commentaire_id WHERE commentaire.lecon_id=$1 GROUP BY reponse.commentaire_id";
const enrollToCourse = "INSERT INTO cours_suivis (users_id, cours_id) VALUES ($1, $2) RETURNING *;";
const isCourseEnrolled = "SELECT * FROM cours_suivis WHERE users_id = $1 AND cours_id=$2;";

const getAllEnrolledCourses = "SELECT * FROM cours_suivis JOIN users ON cours_suivis.users_id=users.id JOIN cours ON cours_suivis.cours_id=cours.id_cours WHERE users.id=$1;";


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
    addCourseToFavorite,
    isCourseInFavorite,
    removeCoursToFavorite,
    getAllFavoriteCourses,
    filterCourses,
    searchCourses,
    addLeconCommentaire,
    getAllLessonCommentaires,
    addLeconReponseCommentaire,
    getAllLessonReponseCommentaires,
    countAllLessonReponseAndCommentaires,
    enrollToCourse,
    isCourseEnrolled,
    getAllEnrolledCourses
}