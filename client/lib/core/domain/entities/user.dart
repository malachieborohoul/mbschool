class User {
  final int id;
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String role;
  final int statut_users;
  final String photo;
  final String sexe;
  final String localisation;
  final String telephone;
  final String qualification;
  final String numCompte;
  final String cv;
  final String token;
  final String verify_code;
  final bool verification_status;


  User( {
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.role,
    required this.statut_users,
    required this.photo,
    required this.sexe,
    required this.localisation,
    required this.telephone,
    required this.qualification,
    required this.numCompte,
    required this.cv,
    required this.token,
    required this.verify_code,
    required this.verification_status,
  });
}